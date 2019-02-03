/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "DataFlowUtils.h"

#include <algorithm>
#include <iterator>
#include <queue>
#include <set>
#include <stack>
#include <string>

#include <llvm/IR/IntrinsicInst.h>
#include <llvm/Support/raw_ostream.h>

#include <phasar/Utils/LLVMShorthands.h>

using namespace psr;

static const llvm::Value* POISON_PILL = reinterpret_cast<const llvm::Value*>("all i need is a unique llvm::Value ptr...");
static const std::vector<const llvm::Value*> EMPTY_SEQ;
static const std::string EMPTY_STRING;

static bool
isMemoryLocationFrame(const llvm::Value* memLocationPart) {

  return llvm::isa<llvm::AllocaInst>(memLocationPart) ||
         llvm::isa<llvm::Argument>(memLocationPart);
}

static bool
isConstantIntEqual(const llvm::ConstantInt* ci1,
                   const llvm::ConstantInt* ci2) {

  // Compare numerical value without type
  //return ci1->getSExtValue() == ci2->getSExtValue();

  // Compare with type
  return ci1 == ci2;
}

static bool
isGEPPartEqual(const llvm::GetElementPtrInst* memLocationFactGEP,
               const llvm::GetElementPtrInst* memLocationInstGEP) {

  bool haveAllConstantIndices = memLocationFactGEP->hasAllConstantIndices() &&
                                memLocationInstGEP->hasAllConstantIndices();
  if (!haveAllConstantIndices) return false;

  bool isNumIndicesEqual = memLocationFactGEP->getNumIndices() == memLocationInstGEP->getNumIndices();

  if (isNumIndicesEqual) {
    // Compare pointer type
    const auto gepFactPtrType = memLocationFactGEP->getPointerOperandType();
    const auto gepInstPtrType = memLocationInstGEP->getPointerOperandType();
    if (gepFactPtrType != gepInstPtrType) return false;

    // Compare indices
    for (unsigned int i = 1; i < memLocationFactGEP->getNumOperands(); i++) {
      const auto *gepFactIndex = llvm::cast<llvm::ConstantInt>(memLocationFactGEP->getOperand(i));
      const auto *gepInstIndex = llvm::cast<llvm::ConstantInt>(memLocationInstGEP->getOperand(i));

      if (!isConstantIntEqual(gepFactIndex, gepInstIndex)) return false;
    }
  }
  else {
    /*
     * For now just expect this to be the result of array decaying...
     *
     * If we pass an array as an argument it is decayed to a pointer and loses type and
     * size information. When we transfer the array from caller to callee we copy the GEP
     * instruction from the caller as this is the only information we have. This GEP instruction
     * carries type information:
     *
     * %arrayidx = getelementptr inbounds [42 x i32], [42 x i32]* %a, i64 0, i64 5
     *
     * However every GEP instruction for that array in the callee refers to the array as a pointer
     * to the first element and performs pointer arithmetic in order to step through the elements.
     * Thus the same location in the callee would be:
     *
     * %arrayidx = getelementptr inbounds i32, i32* %0, i64 5
     *
     * In order to be 100% accurate here we would also need to compare the pointer types...
     */
    const auto nonDecayedArrayGEP = memLocationFactGEP->getNumIndices() > memLocationInstGEP->getNumIndices() ?
                                    memLocationFactGEP :
                                    memLocationInstGEP;

    if (const auto nonDecayedArrayGEPPtrIndex = llvm::dyn_cast<llvm::ConstantInt>(nonDecayedArrayGEP->getOperand(1))) {
      if (!nonDecayedArrayGEPPtrIndex->isZero()) return false;
    } else {
      return false;
    }

    const auto *gepFactIndex = llvm::cast<llvm::ConstantInt>(memLocationFactGEP->getOperand(memLocationFactGEP->getNumOperands() - 1));
    const auto *gepInstIndex = llvm::cast<llvm::ConstantInt>(memLocationInstGEP->getOperand(memLocationInstGEP->getNumOperands() - 1));

    return isConstantIntEqual(gepFactIndex, gepInstIndex);
  }

  return true;
}

static bool
isFirstNMemoryLocationPartsEqual(std::vector<const llvm::Value*> memLocationSeqFact,
                                 std::vector<const llvm::Value*> memLocationSeqInst,
                                 std::size_t n) {

  assert(n > 0);

  bool seqsHaveAtLeastNParts = memLocationSeqFact.size() >= n &&
                               memLocationSeqInst.size() >= n;
  if (!seqsHaveAtLeastNParts) return false;

  bool haveMemLocationFrames = isMemoryLocationFrame(memLocationSeqFact.front()) &&
                               isMemoryLocationFrame(memLocationSeqInst.front());
  if (!haveMemLocationFrames) return false;

  assert(true && "We have vectors that both start with a memory location frame."
                 "Size may differ but we have at least n instances in each.");

  bool isSameMemLocationFrame = memLocationSeqFact.front() == memLocationSeqInst.front();
  if (!isSameMemLocationFrame) return false;

  for (std::size_t i = 1; i < n; ++i) {
    const auto factGEPPtr = llvm::cast<llvm::GetElementPtrInst>(memLocationSeqFact[i]);
    const auto instGEPPtr = llvm::cast<llvm::GetElementPtrInst>(memLocationSeqInst[i]);

    bool isEqual = isGEPPartEqual(factGEPPtr, instGEPPtr);
    if (!isEqual) return false;
  }

  return true;
}

static bool
isUnionBitCast(const llvm::CastInst* castInst) {

  if (const auto bitCastInst = llvm::dyn_cast<llvm::BitCastInst>(castInst)) {
    std::string typeName = DataFlowUtils::getTypeName(bitCastInst->getSrcTy());

    return typeName.find("union") != std::string::npos;
  }
  return false;
}

static std::vector<const llvm::Value*>
getMemoryLocationSeqFromMatrRec(const llvm::Value* memLocationPart) {

  std::vector<const llvm::Value*> memLocationSeq;

  bool isMemLocationFrame = isMemoryLocationFrame(memLocationPart);
  if (isMemLocationFrame) {
    memLocationSeq.push_back(memLocationPart);

    return memLocationSeq;
  }

  if (const auto castInst = llvm::dyn_cast<llvm::CastInst>(memLocationPart)) {
    memLocationSeq = getMemoryLocationSeqFromMatrRec(castInst->getOperand(0));

    bool poisonSeq = isUnionBitCast(castInst);
    if (!poisonSeq) return memLocationSeq;

    // FALLTHROUGH
  }
  else
  if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(memLocationPart)) {
    return getMemoryLocationSeqFromMatrRec(loadInst->getOperand(0));
  }
  else
  if (const auto gepInst = llvm::dyn_cast<llvm::GetElementPtrInst>(memLocationPart)) {
    memLocationSeq = getMemoryLocationSeqFromMatrRec(gepInst->getPointerOperand());

    bool isSeqPoisoned = !memLocationSeq.empty() && memLocationSeq.back() == POISON_PILL;
    if (isSeqPoisoned) return memLocationSeq;

    memLocationSeq.push_back(gepInst);

    return memLocationSeq;
  }

  // Poison seq
  bool isSeqPoisoned = !memLocationSeq.empty() && memLocationSeq.back() == POISON_PILL;
  if (!isSeqPoisoned) memLocationSeq.push_back(POISON_PILL);

  return memLocationSeq;
}

static std::vector<const llvm::Value*>
normalizeMemoryLocationSeq(std::vector<const llvm::Value*> memLocationSeq) {

  assert(!memLocationSeq.empty());

  // Remove poison pill
  bool isSeqPoisoned = memLocationSeq.back() == POISON_PILL;
  if (isSeqPoisoned) memLocationSeq.pop_back();

  if (memLocationSeq.empty()) return memLocationSeq;

  // Remove array decay
  bool isBackArrayDecay = memLocationSeq.back()->getName().contains_lower("arraydecay");
  if (isBackArrayDecay) memLocationSeq.pop_back();

  return memLocationSeq;
}

const std::vector<const llvm::Value*>
DataFlowUtils::getMemoryLocationSeqFromMatr(const llvm::Value* memLocationMatr) {

  auto memLocationSeq = normalizeMemoryLocationSeq(getMemoryLocationSeqFromMatrRec(memLocationMatr));

  assert(memLocationSeq.empty() || isMemoryLocationFrame(memLocationSeq.front()));

  return memLocationSeq;
}

const std::vector<const llvm::Value*>
DataFlowUtils::getMemoryLocationSeqFromFact(const ExtendedValue& memLocationFact) {

  return memLocationFact.getMemLocationSeq();
}

static const llvm::Value*
getMemoryLocationFrameFromFact(const ExtendedValue& memLocationFact) {

  const auto memLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(memLocationFact);
  if (memLocationSeq.empty()) return nullptr;

  return memLocationSeq.front();
}

static const llvm::Value*
getMemoryLocationFrameFromMatr(const llvm::Value* memLocationMatr) {

  const auto memLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(memLocationMatr);
  if (memLocationSeq.empty()) return nullptr;

  return memLocationSeq.front();
}

bool
DataFlowUtils::isMemoryLocationTainted(const ExtendedValue& fact,
                                       const llvm::Value* memLocationMatr) {

  const auto memLocationFactVector = getMemoryLocationSeqFromFact(fact);
  if (memLocationFactVector.empty()) return false;

  const auto memLocationInstVector = getMemoryLocationSeqFromMatr(memLocationMatr);
  if (memLocationInstVector.empty()) return false;

  std::size_t n = memLocationFactVector.size();
  bool isMemLocationsEqual = isFirstNMemoryLocationPartsEqual(memLocationFactVector,
                                                              memLocationInstVector,
                                                              n);
  if (!isMemLocationsEqual) return false;

  return true;
}

bool
DataFlowUtils::isValueTainted(const ExtendedValue& fact,
                              const llvm::Value* inst) {

  return fact.getValue() == inst;
}

bool
DataFlowUtils::isSubsetMemoryLocationSeq(const std::vector<const llvm::Value*> memLocationSeqInst,
                                         const std::vector<const llvm::Value*> memLocationSeqFact) {

  if (memLocationSeqInst.empty()) return false;
  if (memLocationSeqFact.empty()) return false;

  std::size_t n = std::min<std::size_t>(memLocationSeqInst.size(), memLocationSeqFact.size());

  return isFirstNMemoryLocationPartsEqual(memLocationSeqInst,
                                          memLocationSeqFact,
                                          n);
}

const std::vector<const llvm::Value*>
DataFlowUtils::getRelocatableMemoryLocationSeq(const std::vector<const llvm::Value*> taintedMemLocationSeq,
                                               const std::vector<const llvm::Value*> srcMemLocationSeq) {

  std::vector<const llvm::Value*> relocatableMemLocationSeq;

  for (std::size_t i = srcMemLocationSeq.size(); i < taintedMemLocationSeq.size(); ++i) {
    relocatableMemLocationSeq.push_back(taintedMemLocationSeq[i]);
  }

  return relocatableMemLocationSeq;
}

const std::vector<const llvm::Value*>
DataFlowUtils::joinMemoryLocationSeqs(const std::vector<const llvm::Value*> memLocationSeq1,
                                      const std::vector<const llvm::Value*> memLocationSeq2) {

  std::vector<const llvm::Value*> joinedMemLocationSeq;
  joinedMemLocationSeq.reserve(memLocationSeq1.size() + memLocationSeq2.size());

  joinedMemLocationSeq.insert(joinedMemLocationSeq.end(), memLocationSeq1.begin(), memLocationSeq1.end());
  joinedMemLocationSeq.insert(joinedMemLocationSeq.end(), memLocationSeq2.begin(), memLocationSeq2.end());

  return joinedMemLocationSeq;
}

bool
DataFlowUtils::isPatchableArgumentStore(const llvm::Value* srcValue,
                                        ExtendedValue& fact) {

  bool isVarArgFact = fact.isVarArg();
  if (isVarArgFact) {
    bool isIndexEqual = fact.getVarArgIndex() == fact.getCurrentVarArgIndex();
    if (!isIndexEqual) return false;

    if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(srcValue)) {
      bool isSrcVarArg = loadInst->getPointerOperand()->getName().contains_lower("vaarg.addr");
      if (isSrcVarArg) return true;
    }

    return false;
  }

  const auto factMemLocationFrame = getMemoryLocationFrameFromFact(fact);
  if (factMemLocationFrame == nullptr) return false;

  if (const auto patchableArgument = llvm::dyn_cast<llvm::Argument>(factMemLocationFrame)) {
    if (patchableArgument->hasByValAttr()) return false;

    if (const auto srcValueArgument = llvm::dyn_cast<llvm::Argument>(srcValue)) {
      bool isLinkEqual = srcValueArgument == patchableArgument;
      if (isLinkEqual) return true;
    }
  }

  return false;
}

bool
DataFlowUtils::isPatchableArgumentMemcpy(const llvm::Value* srcValue,
                                         const std::vector<const llvm::Value*> srcMemLocationSeq,
                                         ExtendedValue& fact) {

  bool isVarArgFact = fact.isVarArg();
  if (!isVarArgFact) return false;

  bool isIndexEqual = fact.getVarArgIndex() == fact.getCurrentVarArgIndex();
  if (!isIndexEqual) return false;

  bool isSrcMemLocation = !srcMemLocationSeq.empty();
  if (isSrcMemLocation) {
    const auto memLocationFrameType = getTypeName(srcMemLocationSeq.front()->getType());
    bool isMemLocationFrameTypeVaList = memLocationFrameType == "[1 x %struct.__va_list_tag]*";
    if (isMemLocationFrameTypeVaList) return true;
  }
  else
  if (const auto bitCastInst = llvm::dyn_cast<llvm::BitCastInst>(srcValue)) {
    bool isSrcVarArg = bitCastInst->getOperand(0)->getName().contains_lower("vaarg.addr");
    if (isSrcVarArg) return true;
  }

  return false;
}

bool
DataFlowUtils::isPatchableReturnValue(const llvm::Value* srcValue,
                                      ExtendedValue& fact) {

  /*
   * We could also check against the fact which is also a call inst when we
   * have a return value. However as we are not changing the fact after
   * relocation it would be again be taken into account. If we use the patch
   * part it is gone after first patch.
   */
  const auto factMemLocationFrame = getMemoryLocationFrameFromFact(fact);
  if (factMemLocationFrame == nullptr) return false;

  if (const auto patchableCallInst = llvm::dyn_cast<llvm::CallInst>(factMemLocationFrame)) {

    if (const auto srcValueExtractValueInst = llvm::dyn_cast<llvm::ExtractValueInst>(srcValue)) {
      bool isLinkEqual = srcValueExtractValueInst->getAggregateOperand() == patchableCallInst;
      if (isLinkEqual) return true;
    }
    else
    if (const auto srcValueCallInst = llvm::dyn_cast<llvm::CallInst>(srcValue)) {
      bool isLinkEqual = srcValueCallInst == patchableCallInst;
      if (isLinkEqual) return true;
    }
  }

  return false;
}

const std::vector<const llvm::Value*>
DataFlowUtils::patchMemoryLocationFrame(const std::vector<const llvm::Value*> patchableMemLocationSeq,
                                        const std::vector<const llvm::Value*> patchMemLocationSeq) {

  if (patchableMemLocationSeq.empty()) return EMPTY_SEQ;
  if (patchMemLocationSeq.empty()) return EMPTY_SEQ;

  std::vector<const llvm::Value*> patchedMemLocationSeq;
  patchedMemLocationSeq.reserve((patchableMemLocationSeq.size() - 1) + patchMemLocationSeq.size());

  patchedMemLocationSeq.insert(patchedMemLocationSeq.end(), patchMemLocationSeq.begin(), patchMemLocationSeq.end());
  patchedMemLocationSeq.insert(patchedMemLocationSeq.end(), std::next(patchableMemLocationSeq.begin()), patchableMemLocationSeq.end());

  return patchedMemLocationSeq;
}

static long
getNumCoercedArgs(const llvm::Value* value) {
  if (const auto allocaInst = llvm::dyn_cast<llvm::AllocaInst>(value)) {
    return -4711;
  }

  if (const auto bitCastInst = llvm::dyn_cast<llvm::BitCastInst>(value)) {
    long ret = getNumCoercedArgs(bitCastInst->getOperand(0));

    if (ret == -4711) {
      const auto dstType = bitCastInst->getDestTy();
      if (!dstType->isPointerTy()) return -1;

      const auto elementType = dstType->getPointerElementType();

      if (const auto structType = llvm::dyn_cast<llvm::StructType>(elementType)) {
        return static_cast<long>(structType->getNumElements());
      }
      return -1;
    }

    return ret;
  }
  else
  if (const auto gepInst = llvm::dyn_cast<llvm::GetElementPtrInst>(value)) {
    return getNumCoercedArgs(gepInst->getPointerOperand());
  }
  else
  if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(value)) {
    return getNumCoercedArgs(loadInst->getPointerOperand());
  }

  return -1;
}

/*
 * The purpose of this function is to provide a sanitized arg list.
 * Sanitization comprises the following 2 steps:
 *
 * (1) Only keep one coerced argument and fix mem location sequence.
 *     This is extremely important when using varargs as we would
 *     increment the var args index for every coerced element although
 *     we only need one index for the struct. The way we figure out the
 *     amount of coerced args for a struct is to retrieve the bitcast
 *     and count its members. Notes for fixing the mem location sequence
 *     can be found below.
 *
 * (2) Provide a default formal parameter for varargs
 *
 * If the struct is coerced then the indexes are not matching anymore.
 * E.g. if we have the following struct:
 *
 * struct s1 {
 *   int a;
 *   int b;
 *   char *t1;
 * };
 *
 * If we taint t1 we will have Alloca_x -> GEP 2 as our memory location.
 *
 * Now if a and b are coerced from i32, i32 to i64 we will have a struct
 * that only contains two members (i64, i8*). This means that also the
 * GEP indexes are different (there is no GEP 2 anymore). So we just ignore
 * the GEP value and pop it from the memory location and proceed as usual.
 */
const std::vector<std::tuple<const llvm::Value*,
                             const std::vector<const llvm::Value*>,
                             const llvm::Value*>>
DataFlowUtils::getSanitizedArgList(const llvm::CallInst* callInst,
                                   const llvm::Function* destMthd,
                                   const llvm::Value* zeroValue) {

  std::vector<std::tuple<const llvm::Value*,
              const std::vector<const llvm::Value*>,
              const llvm::Value*>> sanitizedArgList;

  for (unsigned i = 0; i < callInst->getNumArgOperands(); ++i) {
    const auto arg = callInst->getOperand(i);
    const auto param = getNthFunctionArgument(destMthd, i);

    auto argMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(arg);

    long numCoersedArgs = getNumCoercedArgs(arg);
    bool isCoersedArg = numCoersedArgs > 0;

    if (isCoersedArg) {
      argMemLocationSeq.pop_back();
      i += numCoersedArgs - 1;
    }

    const auto sanitizedParam = param != nullptr ? param : zeroValue;

    sanitizedArgList.push_back({arg, argMemLocationSeq, sanitizedParam});
  }

  return sanitizedArgList;
}

static std::string
getEndOfBranchLabel(const llvm::TerminatorInst* terminatorInst,
                    const std::string labelPrefix,
                    const std::string endLabelPrefix,
                    std::stack<const llvm::BranchInst*> branchInstStack,
                    std::set<const llvm::TerminatorInst*>& visitedTerminatorInsts) {

  std::string newLabelPrefix = labelPrefix;
  std::string newEndLabelPrefix = endLabelPrefix;

  visitedTerminatorInsts.insert(terminatorInst);

  const auto currentLabel = terminatorInst->getParent()->getName();

  /*
   * Do not check for the first call with the tainted branch as we would
   * pop from an empty stack. Placing the potential push of a branch
   * instruction before is not an option as we can have the case that we
   * are at a merge point of a branch statement but its terminator is again
   * a tainted condition. If there are instructions within that basic block
   * they would all be tainted automatically.
   */
  if (!branchInstStack.empty()) {
    bool isEndOfBranch = currentLabel.contains_lower(endLabelPrefix);
    if (isEndOfBranch) branchInstStack.pop();

    if (branchInstStack.empty()) return currentLabel;
  }

  if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(terminatorInst)) {
    bool isFork = branchInst->getNumSuccessors() > 1;
    if (isFork) {
      const std::string bbLabelThen = branchInst->getOperand(2)->getName();
      const std::string currentLabelPrefix = bbLabelThen.substr(0, bbLabelThen.find('.'));

      if (branchInst->isConditional()) {
        if (currentLabelPrefix == labelPrefix) branchInstStack.push(branchInst);
      }

      newLabelPrefix = currentLabelPrefix;
      newEndLabelPrefix = currentLabelPrefix + "." + "end";
    }
  }

  for (unsigned int i = 0; i < terminatorInst->getNumSuccessors(); ++i) {
    const auto nextTerminatorInst = terminatorInst->getSuccessor(i)->getTerminator();

    bool isAlreadyVisitedTerminatorInst = visitedTerminatorInsts.find(nextTerminatorInst) != visitedTerminatorInsts.end();
    if (!isAlreadyVisitedTerminatorInst) {
      const auto endLabel = getEndOfBranchLabel(nextTerminatorInst,
                                                newLabelPrefix,
                                                newEndLabelPrefix,
                                                branchInstStack,
                                                visitedTerminatorInsts);

      if (endLabel != EMPTY_STRING) return endLabel;
    }
  }

  return EMPTY_STRING;
}

static std::string
getEndOfSwitchLabel(const llvm::SwitchInst* const switchInst) {

  /*
   * If there is no default branch we can obtain the label directly
   * from the switch instruction.
   */
  const auto defaultBB = switchInst->getDefaultDest();
  const auto defaultLabel = defaultBB->getName();
  bool isEpilogLabel = defaultLabel.contains_lower("epilog");
  if (isEpilogLabel) return defaultLabel;

  /*
   * If there is a default set use algorithm as described for branch
   * instructions (see above).
   */
  std::stack<const llvm::SwitchInst*> switchInstStack;

  const llvm::TerminatorInst* terminatorInstPtr = switchInst;
  do {
    if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(terminatorInstPtr)) {
      switchInstStack.push(switchInst);
    }

    bool hasSuccessor = terminatorInstPtr->getNumSuccessors() > 0;
    if (!hasSuccessor) return EMPTY_STRING;

    terminatorInstPtr = terminatorInstPtr->getSuccessor(0)->getTerminator();

    const auto bbLabel = terminatorInstPtr->getParent()->getName();
    bool isEpilog = bbLabel.contains_lower("epilog");
    if (isEpilog) switchInstStack.pop();
  } while (!switchInstStack.empty());

  const auto endOfSwitchLabel = terminatorInstPtr->getParent()->getName();

  return endOfSwitchLabel;
}

std::string
DataFlowUtils::getEndOfBlockLabel(const llvm::Instruction* instruction) {

  if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(instruction)) {
    const auto bbLabelThen = branchInst->getOperand(2)->getName();

    auto labelPrefix = bbLabelThen.substr(0, bbLabelThen.find('.'));
    const auto endLabelPrefix = (labelPrefix + "." + "end").str();

    llvm::outs() << "[TRACK] Checking end of branch label for: " << bbLabelThen << "\n";

    std::set<const llvm::TerminatorInst*> visitedInsts;
    const auto endOfBranchLabel = getEndOfBranchLabel(branchInst,
                                                      labelPrefix,
                                                      endLabelPrefix,
                                                      std::stack<const llvm::BranchInst*>(),
                                                      visitedInsts);

    llvm::outs() << "[TRACK] End of branch label: " << endOfBranchLabel << "\n";

    return endOfBranchLabel;
  }
  else
  if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(instruction)) {
    return getEndOfSwitchLabel(switchInst);
  }

  return EMPTY_STRING;
}

std::string
DataFlowUtils::getBBLabel(const llvm::Instruction* instruction) {

  const auto bbInst = instruction->getParent();
  if (bbInst == nullptr) return "";

  return bbInst->getName();
}

bool
DataFlowUtils::isAutoGENInTaintedBlock(const llvm::Instruction* instruction) {

  return !llvm::isa<llvm::StoreInst>(instruction) &&
         !llvm::isa<llvm::MemTransferInst>(instruction) &&
         !llvm::isa<llvm::BranchInst>(instruction) &&
         !llvm::isa<llvm::SwitchInst>(instruction);
}

bool
DataFlowUtils::isMemoryLocationFact(const ExtendedValue& ev) {

  return !ev.getMemLocationSeq().empty();
}

void
DataFlowUtils::dumpMemoryLocation(const ExtendedValue& ev) {

  bool isMemLocation = isMemoryLocationFact(ev);
  if (isMemLocation) {
    for (const auto memLocationPart : ev.getMemLocationSeq()) {
      llvm::outs() << "[TRACK] "; memLocationPart->print(llvm::outs()); llvm::outs() << "\n";
    }
    bool isVarArg = ev.getVarArgIndex() > -1L;
    if (isVarArg) {
      llvm::outs() << "[TRACK] VarArg Index: " << ev.getVarArgIndex() << "\n";
      llvm::outs() << "[TRACK] Current VarArg Index: " << ev.getCurrentVarArgIndex() << "\n";
    }
  }
}

std::string
DataFlowUtils::getTypeName(const llvm::Type* type) {

  std::string typeName;
  llvm::raw_string_ostream typeRawOutputStream(typeName);
  type->print(typeRawOutputStream);

  return typeRawOutputStream.str();
}

