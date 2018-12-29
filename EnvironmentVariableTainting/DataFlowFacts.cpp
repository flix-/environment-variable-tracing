#include "DataFlowFacts.h"

#include "DataFlowUtils.h"

#include <llvm/IR/Instructions.h>
#include <llvm/Support/raw_ostream.h>

using namespace psr;

static bool
isAllocaInstEqual(const llvm::AllocaInst* allocaInst1, const llvm::AllocaInst* allocaInst2) {
  return allocaInst1 == allocaInst2;
}

static bool
isGEPInstEqual(const llvm::GetElementPtrInst* gepInst1, const llvm::GetElementPtrInst* gepInst2) {
  bool hasSameNumOfOperands = gepInst1->getNumOperands() == gepInst2->getNumOperands();
  if (!hasSameNumOfOperands) return false;

  // Compare Pointer Type
  const auto gepInst1OperandType = gepInst1->getOperand(0)->getType();
  const auto gepInst2OperandType = gepInst2->getOperand(0)->getType();
  if (gepInst1OperandType != gepInst2OperandType) return false;

  // Compare Indices
  for (unsigned int i = 1; i < gepInst1->getNumOperands(); i++) {
    const auto *gepInst1Indice = gepInst1->getOperand(i);
    const auto *gepInst2Indice = gepInst2->getOperand(i);
    if (gepInst1Indice != gepInst2Indice) return false;
  }
  return true;
}

static bool
isBitCastInstEqual(const llvm::BitCastInst* bitCastInst1, const llvm::BitCastInst* bitCastInst2) {
  bool isValueTypeEqual = bitCastInst1->getOperand(0)->getType() == bitCastInst2->getOperand(0)->getType();
  if (!isValueTypeEqual) return false;

  return true;
}

static bool
isMemoryLocationEqual(const llvm::Value* memLocation1, const llvm::Value* memLocation2) {
  const llvm::Value* memLocationPtr1 = memLocation1;
  const llvm::Value* memLocationPtr2 = memLocation2;
  do {
    // Try Alloca
    bool isMemLocation1Alloca = llvm::isa<llvm::AllocaInst>(memLocationPtr1);
    bool isMemLocation2Alloca = llvm::isa<llvm::AllocaInst>(memLocationPtr2);
    if (isMemLocation1Alloca != isMemLocation2Alloca) return false;

    if (isMemLocation1Alloca) {
      const auto memLocation1Alloca = llvm::cast<llvm::AllocaInst>(memLocationPtr1);
      const auto memLocation2Alloca = llvm::cast<llvm::AllocaInst>(memLocationPtr2);
      return isAllocaInstEqual(memLocation1Alloca, memLocation2Alloca);
    }

    // Try GEP
    bool isMemLocation1GEP = llvm::isa<llvm::GetElementPtrInst>(memLocationPtr1);
    bool isMemLocation2GEP = llvm::isa<llvm::GetElementPtrInst>(memLocationPtr2);
    if (isMemLocation1GEP != isMemLocation2GEP) return false;

    if (isMemLocation1GEP) {
      const auto memLocation1GEP = llvm::cast<llvm::GetElementPtrInst>(memLocationPtr1);
      const auto memLocation2GEP = llvm::cast<llvm::GetElementPtrInst>(memLocationPtr2);
      bool isEqual = isGEPInstEqual(memLocation1GEP, memLocation2GEP);
      if (!isEqual) return false;

      memLocationPtr1 = memLocation1GEP->getPointerOperand();
      memLocationPtr2 = memLocation2GEP->getPointerOperand();
      continue;
    }

    // Try BitCast
    bool isMemLocation1BitCast = llvm::isa<llvm::BitCastInst>(memLocationPtr1);
    bool isMemLocation2BitCast = llvm::isa<llvm::BitCastInst>(memLocationPtr2);
    if (isMemLocation1BitCast != isMemLocation2BitCast) return false;

    if (isMemLocation1BitCast) {
      const auto memLocation1BitCast = llvm::cast<llvm::BitCastInst>(memLocationPtr1);
      const auto memLocation2BitCast = llvm::cast<llvm::BitCastInst>(memLocationPtr2);
      bool isEqual = isBitCastInstEqual(memLocation1BitCast, memLocation2BitCast);
      if (!isEqual) return false;

      memLocationPtr1 = memLocation1BitCast->getOperand(0);
      memLocationPtr2 = memLocation2BitCast->getOperand(0);
      continue;
    }
  } while (true);
}

bool
DataFlowFacts::isMemoryLocationInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::Value* memLocation) {
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
DataFlowFacts::removeMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::Value* memLocation) {
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
