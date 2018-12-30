#include "DataFlowFacts.h"

#include "DataFlowUtils.h"

#include <llvm/IR/Instructions.h>
#include <llvm/Support/raw_ostream.h>

using namespace psr;

static const llvm::Value*
getFirstMemoryLocationAfterHighestBitCast(const llvm::Value* value) {
  const llvm::BitCastInst* latestBitCastInst = nullptr;

  const llvm::Instruction* memInstructionPtr = llvm::cast<llvm::Instruction>(value);
  while (!llvm::isa<llvm::AllocaInst>(memInstructionPtr)) {
    bool isBitCast = llvm::isa<llvm::BitCastInst>(memInstructionPtr);
    if (isBitCast) latestBitCastInst = llvm::cast<llvm::BitCastInst>(memInstructionPtr);

    memInstructionPtr = llvm::cast<llvm::Instruction>(memInstructionPtr->getOperand(0));
  }
  if (latestBitCastInst == nullptr) return value;
  return latestBitCastInst->getOperand(0);
}

static bool
isAllocaInstEqual(const llvm::AllocaInst* allocaInst1, const llvm::AllocaInst* allocaInst2) {
  return allocaInst1 == allocaInst2;
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
isSameOpcode(const llvm::Value* op1, const llvm::Value* op2) {
  const auto inst1 = llvm::cast<llvm::Instruction>(op1);
  const auto inst2 = llvm::cast<llvm::Instruction>(op2);

  return inst1->getOpcode() == inst2->getOpcode();
}

static bool
isMemoryLocationEqual(const llvm::Value* memLocationFact, const llvm::Value* memLocationInst) {
  /*
   * We start after the last BitCast because that is the most outer union. Everything within points
   * to the same memory location (same AllocaInst). So if e.g. we have a union that contains x nested
   * structs including y nested arrays all we need to compare is the alloca instruction 1 up to the
   * BitCast instruction...
   */
  const llvm::Value* memLocationFactPtr = getFirstMemoryLocationAfterHighestBitCast(memLocationFact);
  const llvm::Value* memLocationInstPtr = getFirstMemoryLocationAfterHighestBitCast(memLocationInst);

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
  } while (true);
}

bool
DataFlowFacts::isExactMemoryLocationTainted(const MonoSet<const llvm::Value*>& facts, const llvm::Value* memLocation) {
  bool isPtrType = memLocation->getType()->isPointerTy();
  assert(isPtrType && "Memory location must be a Pointer Type");

  for (const auto fact : facts) {
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      const auto memLocationFact = storeFact->getPointerOperand();
      bool isEqual = isMemoryLocationEqual(memLocationFact, memLocation);
      if (isEqual) return true;
    }
  }
  return false;
}

bool
DataFlowFacts::isValueInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::Value* value) {
  return facts.count(value);
}

void
DataFlowFacts::removeExactMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::Value* memLocation) {
  bool isPtrType = memLocation->getType()->isPointerTy();
  assert(isPtrType && "Memory location must be a Pointer Type");

  for (auto it = facts.begin(); it != facts.end(); ) {
    const auto fact = *it;
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      const auto memLocationFact = storeFact->getPointerOperand();
      bool isEqual = isMemoryLocationEqual(memLocationFact, memLocation);
      if (isEqual) {
        it = facts.erase(it);
        continue;
      }
    }
    ++it;
  }
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
