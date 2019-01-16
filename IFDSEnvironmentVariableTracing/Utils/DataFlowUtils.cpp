#include "DataFlowUtils.h"

#include <queue>
#include <stack>
#include <string>

#include <llvm/IR/IntrinsicInst.h>

#include <llvm/Support/raw_ostream.h>

using namespace psr;

static const llvm::Value* POISON_PILL = reinterpret_cast<const llvm::Value*>("ALL I NEED IS A UNIQUE PTR");

//static bool
//isLoadInstEqual(const llvm::LoadInst* loadInst1,
//                const llvm::LoadInst* loadInst2) {

//  return loadInst1->getType() == loadInst2->getType();
//}

//static bool
//isSameOpcode(const llvm::Value* op1,
//             const llvm::Value* op2) {

//  const auto inst1 = llvm::cast<llvm::Instruction>(op1);
//  const auto inst2 = llvm::cast<llvm::Instruction>(op2);

//  return inst1->getOpcode() == inst2->getOpcode();
//}

//static bool
//isAllocaInstEqual(const llvm::AllocaInst* allocaInst1,
//                  const llvm::AllocaInst* allocaInst2) {

//  return allocaInst1 == allocaInst2;
//}

//static const llvm::Value*
//getFirstMemoryLocationAfterHighestBitCast(const llvm::Value* memLocation) {
//
//  const llvm::BitCastInst* latestBitCastInst = nullptr;

//  const llvm::Value* memInstructionPtr = memLocation;
//  while (!llvm::isa<llvm::AllocaInst>(memInstructionPtr)) {
//    if (const auto bitCastInst = llvm::dyn_cast<llvm::BitCastInst>(memInstructionPtr)) {
//      latestBitCastInst = bitCastInst;
//      memInstructionPtr = bitCastInst->getOperand(0);
//    }
//    else if (const auto gepInst = llvm::dyn_cast<llvm::GetElementPtrInst>(memInstructionPtr)) {
//      memInstructionPtr = gepInst->getPointerOperand();
//    }
//    else if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(memInstructionPtr)) {
//      memInstructionPtr = loadInst->getOperand(0);
//    }
//    else {
//      return nullptr;
//    }
//  }
//  if (latestBitCastInst == nullptr) return memLocation;
//  return latestBitCastInst->getOperand(0);
//}

//static bool
//isMemoryLocationStrictlyEqual(const llvm::Value* memLocationFact,
//                              const llvm::Value* memLocationInst) {

//  /*
//   * We start after the last BitCast because that is the most outer union. Everything within does not
//   * change the final memory location. So if e.g. we have a union that contains x nested structs
//   * including y nested arrays all we need to compare is the alloca instruction 1 up to the BitCast
//   * instruction...
//   */
//  const llvm::Value* memLocationFactPtr = getFirstMemoryLocationAfterHighestBitCast(memLocationFact);
//  const llvm::Value* memLocationInstPtr = getFirstMemoryLocationAfterHighestBitCast(memLocationInst);

//  if (memLocationFactPtr == nullptr || memLocationInstPtr == nullptr) return false;

//  do {
//    bool sameOpcode = isSameOpcode(memLocationFactPtr, memLocationInstPtr);
//    if (!sameOpcode) return false;

//    // Try Alloca
//    bool isAlloca = llvm::isa<llvm::AllocaInst>(memLocationFactPtr);
//    if (isAlloca) {
//      const auto memLocationFactAlloca = llvm::cast<llvm::AllocaInst>(memLocationFactPtr);
//      const auto memLocationInstAlloca = llvm::cast<llvm::AllocaInst>(memLocationInstPtr);

//      return isAllocaInstEqual(memLocationFactAlloca, memLocationInstAlloca);
//    }

//    // Try GEP
//    bool isGEP = llvm::isa<llvm::GetElementPtrInst>(memLocationFactPtr);
//    if (isGEP) {
//      const auto memLocationFactGEP = llvm::cast<llvm::GetElementPtrInst>(memLocationFactPtr);
//      const auto memLocationInstGEP = llvm::cast<llvm::GetElementPtrInst>(memLocationInstPtr);

//      bool isEqual = isGEPInstEqual(memLocationFactGEP, memLocationInstGEP);
//      if (!isEqual) return false;

//      memLocationFactPtr = memLocationFactGEP->getPointerOperand();
//      memLocationInstPtr = memLocationInstGEP->getPointerOperand();

//      continue;
//    }

//    // Try Load
//    bool isLoad = llvm::isa<llvm::LoadInst>(memLocationFactPtr);
//    if (isLoad) {
//      const auto memLocationFactLoad = llvm::cast<llvm::LoadInst>(memLocationFactPtr);
//      const auto memLocationInstLoad = llvm::cast<llvm::LoadInst>(memLocationInstPtr);

//      bool isEqual = isLoadInstEqual(memLocationFactLoad, memLocationInstLoad);
//      if (!isEqual) return false;

//      memLocationFactPtr = memLocationFactLoad->getPointerOperand();
//      memLocationInstPtr = memLocationInstLoad->getPointerOperand();

//      continue;
//    }

//    assert(1 == 0 && "Need to check instructions within memory location");
//  } while (true);
//}

static std::string
getTypeName(const llvm::Type* type) {

  std::string typeName;
  llvm::raw_string_ostream typeRawOutputStream(typeName);
  type->print(typeRawOutputStream);

  return typeRawOutputStream.str();
}

static bool
isUnionBitCast(const llvm::BitCastInst* bitCastInst) {

  std::string typeName = getTypeName(bitCastInst->getSrcTy());

  return typeName.find("union") != std::string::npos;
}

static bool
isGEPInstEqual(const llvm::GetElementPtrInst* memLocationFactGEP,
               const llvm::GetElementPtrInst* memLocationInstGEP) {

  bool hasSameNumOfOperands = memLocationFactGEP->getNumOperands() == memLocationInstGEP->getNumOperands();
  if (!hasSameNumOfOperands) return false;

  // Compare Pointer Type
  const auto gepFactOperandType = memLocationFactGEP->getOperand(0)->getType();
  const auto gepInstOperandType = memLocationInstGEP->getOperand(0)->getType();
  if (gepFactOperandType != gepInstOperandType) return false;

  // Compare Indices
  for (unsigned int i = 1; i < memLocationFactGEP->getNumOperands(); i++) {
    const auto *gepFactIndice = memLocationFactGEP->getOperand(i);
    const auto *gepInstIndice = memLocationInstGEP->getOperand(i);
    if (gepFactIndice != gepInstIndice) return false;
  }

  return true;
}

//static bool
//isLastGEPInstancesEqual(std::queue<const llvm::Value*>& factGEPQueue,
//                        std::queue<const llvm::Value*>& instGEPQueue) {

//  assert(factGEPQueue.size() == instGEPQueue.size());
//  assert(factGEPQueue.back() == POISON_PILL);
//  assert(instGEPQueue.back() == POISON_PILL);

//  while (!(factGEPQueue.front() == POISON_PILL)) {
//    const auto factGEPPtr = llvm::dyn_cast<llvm::GetElementPtrInst>(factGEPQueue.front());
//    const auto instGEPPtr = llvm::dyn_cast<llvm::GetElementPtrInst>(instGEPQueue.front());

//    bool isEqual = isGEPInstEqual(factGEPPtr, instGEPPtr);
//    if (!isEqual) return false;

//    factGEPQueue.pop();
//    instGEPQueue.pop();
//  }

//  return true;
//}

static bool
isSameMemoryLocationFrame(const ExtendedValue& fact,
                          const llvm::Value* memLocationFrameFact,
                          const llvm::Value* memLocationFrameInst) {

  const auto patchedMemLocationFrameFact = fact.getPatchedMemLocationFrame();
  if (patchedMemLocationFrameFact != nullptr) {
    return patchedMemLocationFrameFact == memLocationFrameInst;
  }

  return memLocationFrameFact == memLocationFrameInst;
}

static bool
isMemoryLocationFrame(const llvm::Value* memLocation) {

  return llvm::isa<llvm::AllocaInst>(memLocation) ||
         llvm::isa<llvm::Argument>(memLocation);
}

static bool
isFirstNQueueInstancesEqual(const ExtendedValue& fact,
                            std::queue<const llvm::Value*> memLocationFactQueue,
                            std::queue<const llvm::Value*> memLocationInstQueue,
                            size_t n) {

  assert(memLocationFactQueue.back() == POISON_PILL);
  assert(memLocationInstQueue.back() == POISON_PILL);

  bool queuesHaveAtLeastNInstances = memLocationFactQueue.size() > n &&
                                     memLocationInstQueue.size() > n;
  if (!queuesHaveAtLeastNInstances) return false;

  bool haveMemLocationFrames = isMemoryLocationFrame(memLocationFactQueue.front()) &&
                               isMemoryLocationFrame(memLocationInstQueue.front());
  if (!haveMemLocationFrames) return false;

  assert(true && "We have queues that both start with a memory location frame and end with POISON_PILL. "
                 "Size may differ but we have at least n instances in each.");

  bool isSameMemLocationFrame = isSameMemoryLocationFrame(fact,
                                                          memLocationFactQueue.front(),
                                                          memLocationInstQueue.front());
  if (!isSameMemLocationFrame) return false;

  memLocationFactQueue.pop();
  memLocationInstQueue.pop();

  while (--n > 0) {
    const auto factGEPPtr = llvm::cast<llvm::GetElementPtrInst>(memLocationFactQueue.front());
    const auto instGEPPtr = llvm::cast<llvm::GetElementPtrInst>(memLocationInstQueue.front());

    bool isEqual = isGEPInstEqual(factGEPPtr, instGEPPtr);
    if (!isEqual) return false;

    memLocationFactQueue.pop();
    memLocationInstQueue.pop();
  }

  return true;
}

static std::queue<const llvm::Value*>
getMemLocationFrameGEPQueue(const llvm::Value* memLocationValue) {

  std::queue<const llvm::Value*> queue;

  bool isMemLocationFrame = isMemoryLocationFrame(memLocationValue);
  if (isMemLocationFrame) {
    queue.push(memLocationValue);
    return queue;
  }

  if (const auto bitCastInst = llvm::dyn_cast<llvm::BitCastInst>(memLocationValue)) {
    queue = getMemLocationFrameGEPQueue(bitCastInst->getOperand(0));
    bool poisonQueue = isUnionBitCast(bitCastInst);

    if (!poisonQueue) return queue;

    // FALLTHROUGH
  }
  else if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(memLocationValue)) {
    return getMemLocationFrameGEPQueue(loadInst->getOperand(0));
  }
  else if (const auto gepInst = llvm::dyn_cast<llvm::GetElementPtrInst>(memLocationValue)) {
    queue = getMemLocationFrameGEPQueue(gepInst->getPointerOperand());
    bool isPoisoned = !queue.empty() && queue.back() == POISON_PILL;
    if (isPoisoned) return queue;

    queue.push(gepInst);
    return queue;
  }

  // Poison queue
  bool isPoisoned = !queue.empty() && queue.back() == POISON_PILL;
  if (!isPoisoned) queue.push(POISON_PILL);

  return queue;
}

static std::queue<const llvm::Value*>
getPoisonedMemLocationFrameGEPQueue(const llvm::Value* memLocation) {

  std::queue<const llvm::Value*> memLocationQueue = getMemLocationFrameGEPQueue(memLocation);
  if (memLocationQueue.back() != POISON_PILL) memLocationQueue.push(POISON_PILL);

  return memLocationQueue;
}

static const llvm::Value*
getMemoryLocationFromValueFact(const ExtendedValue& fact) {

  if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(fact.getValue())) {
    bool hasPatchedStartMemLocation = fact.getPatchedStartMemLocation() != nullptr;
    if (hasPatchedStartMemLocation) return fact.getPatchedStartMemLocation();

    return storeInst->getPointerOperand();
  }

  return nullptr;
}

bool
DataFlowUtils::isMemoryLocationEqual(const ExtendedValue& fact,
                                     const llvm::Value* memLocationInst) {

  const auto memLocationFact = getMemoryLocationFromValueFact(fact);
  if (memLocationFact == nullptr) return false;

  std::queue<const llvm::Value*> memLocationFactQueue = getPoisonedMemLocationFrameGEPQueue(memLocationFact);
  std::queue<const llvm::Value*> memLocationInstQueue = getPoisonedMemLocationFrameGEPQueue(memLocationInst);

  bool isSameSize = memLocationFactQueue.size() == memLocationInstQueue.size();
  if (!isSameSize) return false;

  size_t allMemoryInstances = memLocationFactQueue.size() - 1;
  bool isMemLocationEqual = isFirstNQueueInstancesEqual(fact,
                                                        memLocationFactQueue,
                                                        memLocationInstQueue,
                                                        allMemoryInstances);
  if (!isMemLocationEqual) return false;

  return true;
}

bool
DataFlowUtils::isValueEqual(const ExtendedValue& fact,
                            const llvm::Value* inst) {

  return fact.getValue() == inst;
}

const llvm::Value*
DataFlowUtils::isMemoryLocationSubsetEqual(const llvm::Value* memLocationInst,
                                           const ExtendedValue& fact) {

  const auto memLocationFact = getMemoryLocationFromValueFact(fact);
  if (memLocationFact == nullptr) return nullptr;

  std::queue<const llvm::Value*> memLocationFactQueue = getPoisonedMemLocationFrameGEPQueue(memLocationFact);
  std::queue<const llvm::Value*> memLocationInstQueue = getPoisonedMemLocationFrameGEPQueue(memLocationInst);

  size_t firstNMemoryInstances = memLocationInstQueue.size() - 1;
  bool isFirstNMemoryLocationsEqual = isFirstNQueueInstancesEqual(fact,
                                                                  memLocationFactQueue,
                                                                  memLocationInstQueue,
                                                                  firstNMemoryInstances);
  if (!isFirstNMemoryLocationsEqual) return nullptr;

  const size_t popCount = memLocationFactQueue.size() - memLocationInstQueue.size();
  for (size_t i = 0; i < popCount; ++i) memLocationFactQueue.pop();

  assert(memLocationFactQueue.front() != POISON_PILL);

  return memLocationFactQueue.front();
}

bool
DataFlowUtils::isMemoryLocationFrameEqual(const ExtendedValue& fact,
                                          const llvm::Value* memLocationInst) {

  const auto memLocationFact = getMemoryLocationFromValueFact(fact);
  if (memLocationFact == nullptr) return false;

  const llvm::Value* memLocationFrameFact = getMemoryLocationFrame(memLocationFact);
  const llvm::Value* memLocationFrameInst = getMemoryLocationFrame(memLocationInst);

  bool gotMemLocationFrames = memLocationFrameFact != nullptr &&
                              memLocationFrameInst != nullptr;
  if (!gotMemLocationFrames) return false;

  bool isSameMemLocationFrame = isSameMemoryLocationFrame(fact,
                                                          memLocationFrameFact,
                                                          memLocationFrameInst);
  if (isSameMemLocationFrame) return true;

  return false;
}

const llvm::Value*
DataFlowUtils::getMemoryLocationFrame(const llvm::Value* memLocationInst) {

  std::queue<const llvm::Value*> memLocationInstQueue = getMemLocationFrameGEPQueue(memLocationInst);

  bool isMemLocationFrame = isMemoryLocationFrame(memLocationInstQueue.front());
  if (isMemLocationFrame) return memLocationInstQueue.front();

  return nullptr;
}

static bool
isEndOfTaintedBranch(const llvm::BranchInst *branchInst,
                     const llvm::Instruction *instruction) {

  const auto bbInst = instruction->getParent();
  if (bbInst == nullptr) return false;

  const auto instructionLabel = bbInst->getName();
  bool isEndOfBranch = instructionLabel.contains_lower("end");
  if (!isEndOfBranch) return false;

  /*
   * We now have an instruction that belongs to the end of a branch
   * statement. We need to figure out if the label matches the one
   * of the branch statement. There are two cases to consider.
   * (1) If the branch does not have an else/else if part then we
   * can match the instruction label directly against the labels of
   * the branch instruction. (2) If there is an else/else if part
   * we need to figure out the label of the block where the branch
   * merges.
   */
  // Case 1
  const auto bbLabel1 = branchInst->getOperand(1)->getName();
  const auto bbLabel2 = branchInst->getOperand(2)->getName();

  bool isBranchWithoutElse = bbLabel1.contains_lower("end") ||
                             bbLabel2.contains_lower("end");

  if (isBranchWithoutElse) {
    bool isMatch = instructionLabel.compare_lower(bbLabel1) == 0 ||
                   instructionLabel.compare_lower(bbLabel2) == 0;
    if (isMatch) {
      return true;
    } else {
      return false;
    }
  }
  // Case 2
  /*
   * The way we determine the basic block where the branch merges
   * is as follows:
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
  std::stack<const llvm::BranchInst*> branchStack;

  const llvm::TerminatorInst* terminatorInstPtr = branchInst;
  do {
    if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(terminatorInstPtr)) {
      if (branchInst->isConditional()) branchStack.push(branchInst);
    }

    terminatorInstPtr = terminatorInstPtr->getSuccessor(0)->getTerminator();

    const auto bbLabel = terminatorInstPtr->getParent()->getName();
    bool isEnd = bbLabel.contains_lower("end");
    if (isEnd) branchStack.pop();
  } while (!branchStack.empty());

  const auto endOfBranchLabel = terminatorInstPtr->getParent()->getName();

  return instructionLabel.compare_lower(endOfBranchLabel) == 0;
}

static bool
isEndOfTaintedSwitch(const llvm::SwitchInst* const switchInst,
                     const llvm::Instruction *instruction) {

  const auto bbInst = instruction->getParent();
  if (bbInst == nullptr) return false;

  const auto instructionLabel = bbInst->getName();
  bool isEndOfSwitch = instructionLabel.contains_lower("epilog");
  if (!isEndOfSwitch) return false;

  /*
   * We now have an instruction that belongs to the end of a switch
   * statement. We need to figure out if the label matches the one
   * of the switch statement (e.g. we don't want to remove the switch
   * statement if it is a nested one). If the default case of the
   * switch statement points to an epilog (no default branch) we can
   * obtain the label immediately (1) if not we need to determine the
   * label of the end of the switch statement (see branch algorithm) (2).
   */
  // Case 1
  const auto defaultBB = switchInst->getDefaultDest();
  const auto defaultLabel = defaultBB->getName();
  bool isEpilogLabel = defaultLabel.contains_lower("epilog");
  if (isEpilogLabel) return instructionLabel.compare_lower(defaultLabel) == 0;

  // Case 2
  std::stack<const llvm::SwitchInst*> switchStack;

  const llvm::TerminatorInst* terminatorInstPtr = switchInst;
  do {
    if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(terminatorInstPtr)) {
      switchStack.push(switchInst);
    }

    terminatorInstPtr = terminatorInstPtr->getSuccessor(0)->getTerminator();

    const auto bbLabel = terminatorInstPtr->getParent()->getName();
    bool isEpilog = bbLabel.contains_lower("epilog");
    if (isEpilog) switchStack.pop();
  } while (!switchStack.empty());

  const auto endOfSwitchLabel = terminatorInstPtr->getParent()->getName();

  return instructionLabel.compare_lower(endOfSwitchLabel) == 0;
}

bool
DataFlowUtils::isEndOfBranchOrSwitchInst(const ExtendedValue& fact,
                                         const llvm::Instruction *instruction) {

  const auto branchOrSwitchInst = fact.getValue();

  if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(branchOrSwitchInst)) {
    return isEndOfTaintedBranch(branchInst, instruction);
  }
  else if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(branchOrSwitchInst)) {
    return isEndOfTaintedSwitch(switchInst, instruction);
  }

  return false;
}
