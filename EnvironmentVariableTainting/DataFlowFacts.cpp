#include "DataFlowFacts.h"

#include "DataFlowUtils.h"

#include <queue>

#include <llvm/IR/Instructions.h>
#include <llvm/IR/IntrinsicInst.h>

#include <llvm/Support/raw_ostream.h>

using namespace psr;

static const llvm::Value* POISON_PILL = reinterpret_cast<const llvm::Value*>("ALL I NEED IS A UNIQUE PTR");

static bool
isLoadInstEqual(const llvm::LoadInst* loadInst1, const llvm::LoadInst* loadInst2) {
  return loadInst1->getType() == loadInst2->getType();
}

static bool
isGEPInstEqual(const llvm::GetElementPtrInst* memLocationFactGEP, const llvm::GetElementPtrInst* memLocationInstGEP) {
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

static bool
isAllocaInstEqual(const llvm::AllocaInst* allocaInst1, const llvm::AllocaInst* allocaInst2) {
  return allocaInst1 == allocaInst2;
}

static bool
isSameOpcode(const llvm::Value* op1, const llvm::Value* op2) {
  const auto inst1 = llvm::cast<llvm::Instruction>(op1);
  const auto inst2 = llvm::cast<llvm::Instruction>(op2);

  return inst1->getOpcode() == inst2->getOpcode();
}

static bool
isLastGEPInstancesEqual(std::queue<const llvm::Value*>& factGEPQueue, std::queue<const llvm::Value*>& instGEPQueue) {
  assert(factGEPQueue.back() == POISON_PILL &&
         instGEPQueue.back() == POISON_PILL);

  bool isSameSize = factGEPQueue.size() == instGEPQueue.size();
  if (!isSameSize) return false;

  while (!(factGEPQueue.front() == POISON_PILL)) {
    const auto factGEPPtr = llvm::dyn_cast<llvm::GetElementPtrInst>(factGEPQueue.front());
    const auto instGEPPtr = llvm::dyn_cast<llvm::GetElementPtrInst>(instGEPQueue.front());

    bool isEqual = isGEPInstEqual(factGEPPtr, instGEPPtr);
    if (!isEqual) return false;

    factGEPQueue.pop();
    instGEPQueue.pop();
  }
  return true;
}

static std::queue<const llvm::Value*>
getAllocaGEPQueueFromMemoryLocation(const llvm::Value *memLocation) {
  std::queue<const llvm::Value*> queue;

  if (const auto allocaInst = llvm::dyn_cast<llvm::AllocaInst>(memLocation)) {
    queue.push(allocaInst);
    return queue;
  }

  if (const auto bitCastInst = llvm::dyn_cast<llvm::BitCastInst>(memLocation)) {
    queue = getAllocaGEPQueueFromMemoryLocation(bitCastInst->getOperand(0));
  }
  else if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(memLocation)) {
    queue = getAllocaGEPQueueFromMemoryLocation(loadInst->getOperand(0));
  }
  else if (const auto gepInst = llvm::dyn_cast<llvm::GetElementPtrInst>(memLocation)) {
    queue = getAllocaGEPQueueFromMemoryLocation(gepInst->getPointerOperand());
    bool isPoisoned = !queue.empty() && queue.back() == POISON_PILL;
    if (isPoisoned) return queue;

    queue.push(gepInst);
    return queue;
  }

  bool isPoisoned = !queue.empty() && queue.back() == POISON_PILL;
  if (!isPoisoned) queue.push(POISON_PILL);

  return queue;
}

static bool
isMemoryLocationLazilyEqual(const llvm::Value* memLocationFact, const llvm::Value* memLocationInst) {
  std::queue<const llvm::Value*> memLocationFactQueue = getAllocaGEPQueueFromMemoryLocation(memLocationFact);
  std::queue<const llvm::Value*> memLocationInstQueue = getAllocaGEPQueueFromMemoryLocation(memLocationInst);

  if (memLocationFactQueue.back() != POISON_PILL) memLocationFactQueue.push(POISON_PILL);
  if (memLocationInstQueue.back() != POISON_PILL) memLocationInstQueue.push(POISON_PILL);

  bool gotAlloca = llvm::isa<llvm::AllocaInst>(memLocationFactQueue.front()) &&
                   llvm::isa<llvm::AllocaInst>(memLocationInstQueue.front());
  if (!gotAlloca) return false;

  bool isSameAlloca = memLocationFactQueue.front() == memLocationInstQueue.front();
  if (!isSameAlloca) return false;

  /*
   * We have reached the same alloca. If we have a struct or array then the alloca
   * contains different values. Comparing GEP instances to figure out the correct
   * location...
   */
  memLocationFactQueue.pop();
  memLocationInstQueue.pop();

  /*
   * If there was no GEP instance in both memory locations we should only have the poison pill
   * on stack...
   */
  bool isOnlyPoisonPillLeft = (memLocationFactQueue.size() == 1) &&
                              (memLocationInstQueue.size() == 1);
  if (isOnlyPoisonPillLeft) return true;

  assert(llvm::isa<llvm::GetElementPtrInst>(memLocationFactQueue.front()));
  assert(llvm::isa<llvm::GetElementPtrInst>(memLocationInstQueue.front()));

  bool isGEPInstancesEqual = isLastGEPInstancesEqual(memLocationFactQueue, memLocationInstQueue);
  if (!isGEPInstancesEqual) return false;

  return true;
}

static const llvm::Value*
getFirstMemoryLocationAfterHighestBitCast(const llvm::Value* memLocation) {
  const llvm::BitCastInst* latestBitCastInst = nullptr;

  const llvm::Value* memInstructionPtr = memLocation;
  while (!llvm::isa<llvm::AllocaInst>(memInstructionPtr)) {
    if (const auto bitCastInst = llvm::dyn_cast<llvm::BitCastInst>(memInstructionPtr)) {
      latestBitCastInst = bitCastInst;
      memInstructionPtr = bitCastInst->getOperand(0);
    }
    else if (const auto gepInst = llvm::dyn_cast<llvm::GetElementPtrInst>(memInstructionPtr)) {
      memInstructionPtr = gepInst->getPointerOperand();
    }
    else if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(memInstructionPtr)) {
      memInstructionPtr = loadInst->getOperand(0);
    }
    else {
      return nullptr;
    }
  }
  if (latestBitCastInst == nullptr) return memLocation;
  return latestBitCastInst->getOperand(0);
}

static bool
isMemoryLocationStrictlyEqual(const llvm::Value* memLocationFact, const llvm::Value* memLocationInst) {
  /*
   * We start after the last BitCast because that is the most outer union. Everything within does not
   * change the final memory location. So if e.g. we have a union that contains x nested structs
   * including y nested arrays all we need to compare is the alloca instruction 1 up to the BitCast
   * instruction...
   */
  const llvm::Value* memLocationFactPtr = getFirstMemoryLocationAfterHighestBitCast(memLocationFact);
  const llvm::Value* memLocationInstPtr = getFirstMemoryLocationAfterHighestBitCast(memLocationInst);

  if (memLocationFactPtr == nullptr || memLocationInstPtr == nullptr) return false;

  do {
    bool sameOpcode = isSameOpcode(memLocationFactPtr, memLocationInstPtr);
    if (!sameOpcode) return false;

    // Try Alloca
    bool isAlloca = llvm::isa<llvm::AllocaInst>(memLocationFactPtr);
    if (isAlloca) {
      const auto memLocationFactAlloca = llvm::cast<llvm::AllocaInst>(memLocationFactPtr);
      const auto memLocationInstAlloca = llvm::cast<llvm::AllocaInst>(memLocationInstPtr);

      return isAllocaInstEqual(memLocationFactAlloca, memLocationInstAlloca);
    }

    // Try GEP
    bool isGEP = llvm::isa<llvm::GetElementPtrInst>(memLocationFactPtr);
    if (isGEP) {
      const auto memLocationFactGEP = llvm::cast<llvm::GetElementPtrInst>(memLocationFactPtr);
      const auto memLocationInstGEP = llvm::cast<llvm::GetElementPtrInst>(memLocationInstPtr);

      bool isEqual = isGEPInstEqual(memLocationFactGEP, memLocationInstGEP);
      if (!isEqual) return false;

      memLocationFactPtr = memLocationFactGEP->getPointerOperand();
      memLocationInstPtr = memLocationInstGEP->getPointerOperand();

      continue;
    }

    // Try Load
    bool isLoad = llvm::isa<llvm::LoadInst>(memLocationFactPtr);
    if (isLoad) {
      const auto memLocationFactLoad = llvm::cast<llvm::LoadInst>(memLocationFactPtr);
      const auto memLocationInstLoad = llvm::cast<llvm::LoadInst>(memLocationInstPtr);

      bool isEqual = isLoadInstEqual(memLocationFactLoad, memLocationInstLoad);
      if (!isEqual) return false;

      memLocationFactPtr = memLocationFactLoad->getPointerOperand();
      memLocationInstPtr = memLocationInstLoad->getPointerOperand();

      continue;
    }

    assert(1 == 0 && "Need to check instructions within memory location");
  } while (true);
}

static const llvm::Value*
getMemoryLocationFromFact(const llvm::Value* value) {
  if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(value)) {
    return storeInst->getPointerOperand();
  }
  if (const auto memCpyInst = llvm::dyn_cast<llvm::MemCpyInst>(value)) {
    return memCpyInst->getRawDest();
  }
  return nullptr;
}

static bool
isMemoryLocationEqual(const llvm::Value* memLocationFact, const llvm::Value* memLocationInst) {
  return isMemoryLocationLazilyEqual(memLocationFact, memLocationInst);
}

bool
DataFlowFacts::isMemoryLocationTainted(const MonoSet<const llvm::Value*>& facts, const llvm::Value* memLocation) {
  for (const auto fact : facts) {
    if (const auto memLocationFact = getMemoryLocationFromFact(fact)) {
      bool isEqual = isMemoryLocationEqual(memLocationFact, memLocation);
      if (isEqual) return true;
    }
  }
  return false;
}

bool
DataFlowFacts::isValueTainted(const MonoSet<const llvm::Value*>& facts, const llvm::Value* value) {
  return facts.count(value);
}

unsigned long
DataFlowFacts::removeMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::Value* memLocation) {
  unsigned long cnt = 0;
  for (auto it = facts.begin(); it != facts.end(); ) {
    const auto fact = *it;
    if (const auto memLocationFact = getMemoryLocationFromFact(fact)) {
      bool isEqual = isMemoryLocationEqual(memLocationFact, memLocation);
      if (isEqual) {
        it = facts.erase(it);
        ++cnt;
        continue;
      }
    }
    ++it;
  }
  return cnt;
}

const llvm::Value*
DataFlowFacts::findBranchOrSwitchInstInFacts(const MonoSet<const llvm::Value*>& facts) {
  for (const auto fact : facts) {
    bool isBranchInst = llvm::isa<llvm::BranchInst>(fact);
    bool isSwitchInst = llvm::isa<llvm::SwitchInst>(fact);
    if (isBranchInst || isSwitchInst) return fact;
  }
  return nullptr;
}
