/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "DataFlowUtils.h"

#include <algorithm>
#include <queue>
#include <stack>
#include <string>

#include <llvm/IR/IntrinsicInst.h>

#include <llvm/Support/raw_ostream.h>

using namespace psr;

static const llvm::Value* POISON_PILL = reinterpret_cast<const llvm::Value*>("all i need is a unique llvm::Value ptr...");
static const std::vector<const llvm::Value*> EMPTY_SEQ;

static bool
isMemoryLocationFrame(const llvm::Value* memLocationPart) {

  return llvm::isa<llvm::AllocaInst>(memLocationPart) ||
         llvm::isa<llvm::Argument>(memLocationPart);
}

static bool
isUnionBitCast(const llvm::BitCastInst* bitCastInst) {

  std::string typeName = DataFlowUtils::getTypeName(bitCastInst->getSrcTy());

  return typeName.find("union") != std::string::npos;
}

static bool
isGEPPartEqual(const llvm::GetElementPtrInst* memLocationFactGEP,
               const llvm::GetElementPtrInst* memLocationInstGEP) {

  bool isNumIndicesEqual = memLocationFactGEP->getNumIndices() == memLocationInstGEP->getNumIndices();

  if (isNumIndicesEqual) {
    // Compare pointer type
    const auto gepFactOperandType = memLocationFactGEP->getOperand(0)->getType();
    const auto gepInstOperandType = memLocationInstGEP->getOperand(0)->getType();
    if (gepFactOperandType != gepInstOperandType) return false;

    // Compare Indices
    for (unsigned int i = 1; i < memLocationFactGEP->getNumOperands(); i++) {
      const auto *gepFactIndice = memLocationFactGEP->getOperand(i);
      const auto *gepInstIndice = memLocationInstGEP->getOperand(i);
      if (gepFactIndice != gepInstIndice) return false;
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

    return memLocationFactGEP->getOperand(memLocationFactGEP->getNumOperands() - 1) ==
           memLocationInstGEP->getOperand(memLocationInstGEP->getNumOperands() - 1);
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

static std::vector<const llvm::Value*>
getMemoryLocationSeqFromMatrRec(const llvm::Value* memLocationPart) {

  std::vector<const llvm::Value*> memLocationSeq;

  bool isMemLocationFrame = isMemoryLocationFrame(memLocationPart);
  if (isMemLocationFrame) {
    memLocationSeq.push_back(memLocationPart);
    return memLocationSeq;
  }

  if (const auto bitCastInst = llvm::dyn_cast<llvm::BitCastInst>(memLocationPart)) {
    memLocationSeq = getMemoryLocationSeqFromMatrRec(bitCastInst->getOperand(0));
    bool poisonSeq = isUnionBitCast(bitCastInst);

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

  bool isSeqPoisoned = memLocationSeq.back() == POISON_PILL;
  if (isSeqPoisoned) memLocationSeq.pop_back();

  return memLocationSeq;
}

const std::vector<const llvm::Value*>
DataFlowUtils::getMemoryLocationSeqFromMatr(const llvm::Value* memLocationMatr) {

  auto memLocationSeq = normalizeMemoryLocationSeq(getMemoryLocationSeqFromMatrRec(memLocationMatr));

  assert(memLocationSeq.empty() || isMemoryLocationFrame(memLocationSeq.front()));

  return memLocationSeq;
}

static std::vector<const llvm::Value*>
getMemoryLocationSeqFromFact(const ExtendedValue& memLocationFact) {

  return memLocationFact.getMemLocationSeq();
}

static const llvm::Value*
getMemoryLocationFrameFromFact(const ExtendedValue& memLocationFact) {

  const auto memLocationSeq = getMemoryLocationSeqFromFact(memLocationFact);
  if (memLocationSeq.empty()) return nullptr;

  return memLocationSeq.front();
}

const llvm::Value*
DataFlowUtils::getMemoryLocationFrameFromMatr(const llvm::Value* memLocationMatr) {

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
DataFlowUtils::isMemoryLocationFrameEqual(const ExtendedValue& fact,
                                          const llvm::Value* memLocationMatr) {

  const auto memLocationFrameFact = getMemoryLocationFrameFromFact(fact);
  const auto memLocationFrameInst = getMemoryLocationFrameFromMatr(memLocationMatr);

  bool haveMemLocationFrame = memLocationFrameFact && memLocationFrameFact;
  if (!haveMemLocationFrame) return false;

  bool isSameMemLocationFrame = memLocationFrameFact == memLocationFrameInst;
  if (!isSameMemLocationFrame) return false;

  return true;
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
DataFlowUtils::getSubsetMemoryLocationSeq(const llvm::Value* memLocationMatr,
                                          const ExtendedValue& fact) {

  const auto memLocationSeqInst = getMemoryLocationSeqFromMatr(memLocationMatr);
  const auto memLocationSeqFact = getMemoryLocationSeqFromFact(fact);

  bool isMemLocationSubsetOfTaintedMemLocation = isSubsetMemoryLocationSeq(memLocationSeqInst,
                                                                           memLocationSeqFact);
  if (!isMemLocationSubsetOfTaintedMemLocation) return EMPTY_SEQ;

  return memLocationSeqInst;
}

bool
DataFlowUtils::isValueTainted(const ExtendedValue& fact,
                              const llvm::Value* inst) {

  return fact.getValue() == inst;
}

const std::vector<const llvm::Value*>
DataFlowUtils::createRelocatedMemoryLocationSeq(const std::vector<const llvm::Value*> taintedMemLocationSeq,
                                                const std::vector<const llvm::Value*> dstMemLocationSeq,
                                                std::size_t srcLength) {
  /*
   * relocatedDstMemLocationSeq := <prefix> <suffix>
   * prefix := dstMemLocationSeq
   * suffix := taintedMemLocationSeq - first srcLength parts
   */

  std::vector<const llvm::Value*> relocatedDstMemLocationSeq = dstMemLocationSeq;

  for (std::size_t i = srcLength; i < taintedMemLocationSeq.size(); ++i) {
    relocatedDstMemLocationSeq.push_back(taintedMemLocationSeq[i]);
  }

  return relocatedDstMemLocationSeq;
}

static std::string
getEndOfBranchLabel(const llvm::BranchInst *branchInst) {
  /*
   * If the branch does not have an else part then we can
   * obtain the label directly from the branch instruction.
   */
  const auto bbLabel1 = branchInst->getOperand(1)->getName();
  const auto bbLabel2 = branchInst->getOperand(2)->getName();

  if (bbLabel1.contains_lower("end")) return bbLabel1;
  if (bbLabel2.contains_lower("end")) return bbLabel2;

  /*
   * The way we determine the basic block where the branch merges
   * when we have an else part is as follows:
   *
   * Starting with the branch instruction whenever we encounter a
   * conditional branch instruction (beginning of a new branch)
   * we push it on the stack. Then we follow one side of the branch
   * (here left side). Whenever we encounter a basic block with an
   * "end" label (end of a branch) we pop the stack as this means
   * the branch instruction has merged. If we pop our initial branch
   * instruction the stack is empty and we have reached the merge
   * block of the branch. terminatorInstPtr will point to the
   * basic block where the branch instruction has merged.
   */
  std::stack<const llvm::BranchInst*> branchInstStack;

  const llvm::TerminatorInst* terminatorInstPtr = branchInst;
  do {
    if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(terminatorInstPtr)) {
      if (branchInst->isConditional()) branchInstStack.push(branchInst);
    }

    terminatorInstPtr = terminatorInstPtr->getSuccessor(0)->getTerminator();

    const auto bbLabel = terminatorInstPtr->getParent()->getName();
    bool isEnd = bbLabel.contains_lower("end");
    if (isEnd) branchInstStack.pop();

  } while (!branchInstStack.empty());

  const auto endOfBranchLabel = terminatorInstPtr->getParent()->getName();

  return endOfBranchLabel;
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
    return getEndOfBranchLabel(branchInst);
  }
  else
  if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(instruction)) {
    return getEndOfSwitchLabel(switchInst);
  }

  return std::string();
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
DataFlowUtils::isMemoryLocation(const ExtendedValue& ev) {
  return !ev.getMemLocationSeq().empty();
}

void
DataFlowUtils::dumpMemoryLocation(const ExtendedValue& ev) {

  const auto value = ev.getValue();

  bool isMemLocation = isMemoryLocation(ev);
  if (isMemLocation) {
    llvm::outs() << "[TRACK] "; value->print(llvm::outs()); llvm::outs() << "\n";
    for (const auto memLocationPart : ev.getMemLocationSeq()) {
      llvm::outs() << "[TRACK] "; memLocationPart->print(llvm::outs()); llvm::outs() << "\n";
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
