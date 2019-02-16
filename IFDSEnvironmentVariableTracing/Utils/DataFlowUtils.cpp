/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "DataFlowUtils.h"

#include <algorithm>
#include <ctime>
#include <iterator>
#include <queue>
#include <set>
#include <sstream>
#include <stack>
#include <string>

#include <llvm/Analysis/PostDominators.h>

#include <llvm/IR/IntrinsicInst.h>
#include <llvm/Support/raw_ostream.h>

#include <phasar/Utils/LLVMShorthands.h>

using namespace psr;

static const llvm::Value* POISON_PILL = reinterpret_cast<const llvm::Value*>("all i need is a unique llvm::Value ptr...");
static const std::string SUBSTITUTION_WILDCARD = ""; // Must be empty string to match .end automatically!

static const std::vector<const llvm::Value*> EMPTY_SEQ;
static const std::set<std::string> EMPTY_STRING_SET;

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

bool
DataFlowUtils::isValueTainted(const llvm::Value* currentInst,
                              const ExtendedValue& fact) {

  return currentInst == fact.getValue();
}

bool
DataFlowUtils::isMemoryLocationTainted(const llvm::Value* memLocationMatr,
                                       const ExtendedValue& fact) {

  const auto memLocationInstSeq = getMemoryLocationSeqFromMatr(memLocationMatr);
  if (memLocationInstSeq.empty()) return false;

  const auto memLocationFactSeq = getMemoryLocationSeqFromFact(fact);
  if (memLocationFactSeq.empty()) return false;

  return isSubsetMemoryLocationSeq(memLocationInstSeq,
                                   memLocationFactSeq);
}

bool
DataFlowUtils::isSubsetMemoryLocationSeq(const std::vector<const llvm::Value*> memLocationSeqInst,
                                         const std::vector<const llvm::Value*> memLocationSeqFact) {

  if (memLocationSeqInst.empty()) return false;
  if (memLocationSeqFact.empty()) return false;

  std::size_t n = std::min<std::size_t>(memLocationSeqInst.size(),
                                        memLocationSeqFact.size());

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

    sanitizedArgList.push_back(std::make_tuple(arg, argMemLocationSeq, sanitizedParam));
  }

  return sanitizedArgList;
}

static const llvm::BasicBlock*
getEndOfSwitchBlock(const llvm::TerminatorInst* terminatorInst,
                    std::stack<std::string> labelPrefixStack,
                    std::set<std::string> visitedNodes) {

  const auto currentBB = terminatorInst->getParent();
  const auto currentLabel = currentBB->getName();

  visitedNodes.insert(currentLabel);

  if (!labelPrefixStack.empty()) {
    const auto endLabelPrefix = "sw.epilog";

    bool isEndOfSwitch = currentLabel.contains_lower(endLabelPrefix);
    if (isEndOfSwitch) labelPrefixStack.pop();

    if (labelPrefixStack.empty()) return currentBB;
  }

  if (llvm::isa<llvm::SwitchInst>(terminatorInst)) labelPrefixStack.push(currentLabel);

  for (unsigned int i = 0; i < terminatorInst->getNumSuccessors(); ++i) {
    const auto nextBB = terminatorInst->getSuccessor(i);
    const auto nextLabel = nextBB->getName();

    bool isNextNodeAlreadyVisited = visitedNodes.find(nextLabel) != visitedNodes.end();
    if (isNextNodeAlreadyVisited) continue;

    const auto nextTerminatorInst = nextBB->getTerminator();

    const auto endOfSwitchBB = getEndOfSwitchBlock(nextTerminatorInst,
                                                   labelPrefixStack,
                                                   visitedNodes);

    if (endOfSwitchBB != nullptr) return endOfSwitchBB;
  }

  return nullptr;
}

static bool
isSubstitutionWildcard(std::string bbLabel) {

  bool containsTrueOrFalse = bbLabel.find("true") != std::string::npos ||
                             bbLabel.find("false") != std::string::npos;

  return containsTrueOrFalse;
  //return std::count(bbLabel.begin(), bbLabel.end(), '.') > 1;
}

static std::string
getPrefixFromLabel(std::string bbLabel) {

  if (isSubstitutionWildcard(bbLabel)) return SUBSTITUTION_WILDCARD;

  return bbLabel.substr(0, bbLabel.find('.'));
}

/*
 * This algorithm finds the mergepoint for a given conditional branch instruction.
 * It works based on naming conventions for basic block labels. We assume that in
 * the general case a starting point label $labelPrefix.* ($labelPrefix := 'if',
 * 'for', 'do' etc.) ends in a basic block $labelPrefix.end.*.
 * We first push $labelPrefix to a stack. Whenever we encounter a new conditional
 * branch we also push its $labelPrefix. Popping from stack occurs when we have a
 * basic block $labelPrefix.end.*. As soon as the stack is empty we have reached
 * our mergepoint.
 *
 * There are certain cases where a given $labelPrefix does not have a corresponding
 * end label. In particular they start with $labelPrefix_x and will be changed to
 * $labelPrefix_y during processing and we can find $labelPrefix_y.end.*. Those cases
 * will be handled by a special value SUBSTITUTION_WILDCARD. If we have such a value
 * on our stack we 1) do not push other SUBSTITUTION_WILDCARDS until substitution
 * occurs, 2) we substitute it when we have a label prefix != SUBSTITUTION_WILDCARD
 * and 3) we match every *.end block with the SUBSTITUTION_WILDCARD.
 */
const llvm::BasicBlock*
getEndOfBranchBlock(const llvm::TerminatorInst* terminatorInst,
                    std::stack<std::string> labelPrefixStack,
                    std::set<std::string> visitedNodes) {

  const auto currentBB = terminatorInst->getParent();
  const auto currentLabel = currentBB->getName();

  visitedNodes.insert(currentLabel);

  if (!labelPrefixStack.empty()) {
    const auto endLabelPrefix = labelPrefixStack.top() + ".end";

    bool isEndOfBranch = currentLabel.contains_lower(endLabelPrefix);
    if (isEndOfBranch) labelPrefixStack.pop();

    if (labelPrefixStack.empty()) return currentBB;
  }

  for (unsigned int i = 0; i < terminatorInst->getNumSuccessors(); ++i) {
    const auto nextBB = terminatorInst->getSuccessor(i);
    const auto nextLabel = nextBB->getName();

    bool isNextNodeAlreadyVisited = visitedNodes.find(nextLabel) != visitedNodes.end();
    if (isNextNodeAlreadyVisited) continue;

    std::stack<std::string> nextLabelPrefixStack = labelPrefixStack;

    if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(terminatorInst)) {
      if (branchInst->isConditional()) {
        bool isTopSubstitutionWildcard = !nextLabelPrefixStack.empty() &&
                                          nextLabelPrefixStack.top() == SUBSTITUTION_WILDCARD;
        if (isTopSubstitutionWildcard) nextLabelPrefixStack.pop();

        nextLabelPrefixStack.push(getPrefixFromLabel(nextLabel));
      }
    }

    const auto nextTerminatorInst = nextBB->getTerminator();

    const auto endOfBranchBB = getEndOfBranchBlock(nextTerminatorInst,
                                                   nextLabelPrefixStack,
                                                   visitedNodes);

    if (endOfBranchBB != nullptr) return endOfBranchBB;
  }

  return nullptr;
}

static const std::vector<llvm::BasicBlock*>
getPostDominators(const llvm::DomTreeNodeBase<llvm::BasicBlock>* postDomTreeNode,
                  const llvm::BasicBlock* startOfTaintedBlockBB) {

  const auto currentBB = postDomTreeNode->getBlock();
  bool isStartOfTaintedBlockBB = currentBB == startOfTaintedBlockBB;

  if (isStartOfTaintedBlockBB) return { currentBB };

  for (const auto postDomTreeChild : postDomTreeNode->getChildren()) {
    auto childNodes = getPostDominators(postDomTreeChild,
                                        startOfTaintedBlockBB);
    if (!childNodes.empty()) {
      childNodes.push_back(currentBB);

      return childNodes;
    }
  }

  return std::vector<llvm::BasicBlock*>();
}

const llvm::BasicBlock*
DataFlowUtils::getEndOfTaintedBlock(const llvm::BasicBlock* basicBlock) {

  const auto terminatorInst = basicBlock->getTerminator();
  const auto function = const_cast<llvm::Function*>(basicBlock->getParent());

  llvm::PostDominatorTree postDominatorTree;
  postDominatorTree.recalculate(*function);

  const auto postDominators = getPostDominators(postDominatorTree.getRootNode(),
                                                basicBlock);

  const llvm::BasicBlock* endOfTaintedBlock;

  if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(terminatorInst)) {
    endOfTaintedBlock = getEndOfBranchBlock(branchInst,
                                            std::stack<std::string>(),
                                            std::set<std::string>());
  }
  else
  if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(terminatorInst)) {
    endOfTaintedBlock = getEndOfSwitchBlock(switchInst,
                                            std::stack<std::string>(),
                                            std::set<std::string>());
  }
  else {
    return nullptr;
  }

  const auto endOfTaintedBlockLabel = endOfTaintedBlock ? endOfTaintedBlock->getName() : "";

  llvm::outs() << "[TRACK] End of tainted block label: " << endOfTaintedBlockLabel << "\n";

  bool isBlockClosed = std::find(postDominators.begin(),
                                 postDominators.end(),
                                 endOfTaintedBlock) != postDominators.end();

  if (isBlockClosed) return endOfTaintedBlock;

  return postDominators.size() > 1 ? postDominators[1] : nullptr;
}

/*
 * We are removing the tainted branch instruction from facts if the instruction's
 * basic block label matches the one of the trainted branch end block. Note that
 * we remove it after the phi node making sure that the phi node is auto added
 * whenever we came from a tainted branch.
 */
bool
DataFlowUtils::removeTaintedBlockInst(const ExtendedValue& fact,
                                      const llvm::Instruction* currentInst) {

  bool isPhiNode = llvm::isa<llvm::PHINode>(currentInst);
  if (isPhiNode) return false;

  const auto currentBB = currentInst->getParent();
  const auto currentLabel = currentBB->getName();

  return currentLabel == fact.getEndOfTaintedBlockLabel();
}

bool
DataFlowUtils::isAutoGENInTaintedBlock(const llvm::Instruction* currentInst) {

  return !llvm::isa<llvm::StoreInst>(currentInst) &&
         !llvm::isa<llvm::MemTransferInst>(currentInst) &&
         !llvm::isa<llvm::BranchInst>(currentInst) &&
         !llvm::isa<llvm::SwitchInst>(currentInst);
}

bool
DataFlowUtils::isMemoryLocationFact(const ExtendedValue& ev) {

  return !ev.getMemLocationSeq().empty();
}

bool
DataFlowUtils::isKillAfterStoreFact(const ExtendedValue& ev) {

  return !isMemoryLocationFact(ev) &&
         !llvm::isa<llvm::CallInst>(ev.getValue());
}

bool
DataFlowUtils::isCheckOperandsInst(const llvm::Instruction* currentInst) {

  bool isLoad = llvm::isa<llvm::LoadInst>(currentInst);
  if (isLoad) return false;

  return llvm::isa<llvm::UnaryInstruction>(currentInst) ||
         llvm::isa<llvm::BinaryOperator>(currentInst) ||
         llvm::isa<llvm::CmpInst>(currentInst) ||
         llvm::isa<llvm::SelectInst>(currentInst);
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

std::string
DataFlowUtils::getTraceFilename(std::string entryPoint) {

  time_t time = std::time(nullptr);
  long now = static_cast<long> (time);

  std::stringstream traceFileStream;
  traceFileStream << "static" << "-"
                  << entryPoint << "-"
                  << now << "-"
                  << "trace.txt";

  return traceFileStream.str();
}
