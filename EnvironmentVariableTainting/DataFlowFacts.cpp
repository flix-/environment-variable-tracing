#include "DataFlowFacts.h"

#include "DataFlowUtils.h"

#include <llvm/IR/Instructions.h>

using namespace psr;

static bool
isAllocaInstInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::AllocaInst* allocaInst) {
  for (const auto fact : facts) {
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      if (const auto allocaFact = llvm::dyn_cast<llvm::AllocaInst>(storeFact->getPointerOperand())) {
        bool isEqual = allocaFact == allocaInst;
        if (isEqual) return true;
      }
    }
  }
  return false;
}

static bool
isGEPInstInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::GetElementPtrInst* gepInst) {
  for (const auto &fact : facts) {
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      if (const auto gepFact = llvm::dyn_cast<llvm::GetElementPtrInst>(storeFact->getPointerOperand())) {
        const llvm::GetElementPtrInst* gepInstPtr = gepInst;
        const llvm::GetElementPtrInst* gepFactPtr = gepFact;
        do {
          bool isEqual = DataFlowUtils::isGEPInstEqual(gepInstPtr, gepFactPtr);
          if (!isEqual) break;

          // if operand pointer was alloca instruction we are done
          bool isFinal = llvm::isa<llvm::AllocaInst>(gepInstPtr->getPointerOperand());
          if (isFinal) return true;

          // continue with inner GEP
          gepInstPtr = llvm::cast<llvm::GetElementPtrInst>(gepInstPtr->getPointerOperand());
          gepFactPtr = llvm::cast<llvm::GetElementPtrInst>(gepFactPtr->getPointerOperand());
        } while (true);
      }
    }
  }
  return false;
}

static bool
isBitCastInstInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::BitCastInst* bitCastInst) {
  for (const auto fact : facts) {
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      if (const auto bitCastFact = llvm::dyn_cast<llvm::BitCastInst>(storeFact->getPointerOperand())) {
        const auto allocaFact = bitCastFact->getOperand(0);
        const auto allocaInst = bitCastInst->getOperand(0);
        bool isEqual = allocaFact == allocaInst;
        if (isEqual) return true;
      }
    }
  }
  return false;
}

bool
DataFlowFacts::isMemoryLocationInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::Value* value) {
  /*
   * If we get an alloca instruction e.g. from a load instruction we need to check
   * every tainted store instruction for that address.
   */
  if (const auto allocaInst = llvm::dyn_cast<llvm::AllocaInst>(value)) {
    return isAllocaInstInFacts(facts, allocaInst);
  }
  /*
   * We cannot compare a GEP instruction via object reference as for every load a new
   * instance will be created. Although it possibly holds the same address as a GEP instruction
   * already part of the set of facts comparison via pointer yields wrong results. Apply own
   * equality logic supporting nested GEP's. As with alloca instructions we need to search
   * all store instructions.
   */
  if (const auto gepInst = llvm::dyn_cast<llvm::GetElementPtrInst>(value)) {
    return isGEPInstInFacts(facts, gepInst);
  }
  /*
   * Unions... Check every tainted store instruction for a bitCastInst and whether they are
   * pointing to the same alloca instance.
   */
  if (const auto bitCastInst = llvm::dyn_cast<llvm::BitCastInst>(value)) {
    return isBitCastInstInFacts(facts, bitCastInst);
  }

  throw std::runtime_error("We got a memory location of an unknown type -- Did we miss sth.?");
}

bool
DataFlowFacts::isValueInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::Value* value) {
  /*
   * Compare via object reference
   */
  return facts.count(value);
}

static void
removeAllocaMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::AllocaInst* allocaInst) {
  for (auto it = facts.begin(); it != facts.end(); ) {
    const auto fact = *it;
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      if (const auto allocaFact = llvm::dyn_cast<llvm::AllocaInst>(storeFact->getPointerOperand())) {
        bool isEqual = allocaFact == allocaInst;
        if (isEqual) {
          it = facts.erase(it);
          /*
           * There can be more than one store statement pointing to the same alloca so we need to
           * delete all of them. Example:
           *
           * int a;
           * switch (x) {
           * case 0:
           *    a = 1;
           *    break;
           * case 1:
           *    a = 2;
           *    break;
           * default:
           *    a = 3;
           * }
           */
          continue;
        }
      }
    }
    ++it;
  }
}

static void
removeGEPMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::GetElementPtrInst* gepInst) {
  for (auto it = facts.begin(); it != facts.end(); ) {
    const auto fact = *it;
    bool isIteratorIncremented = false;

    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      if (const auto gepFact = llvm::dyn_cast<llvm::GetElementPtrInst>(storeFact->getPointerOperand())) {
        const llvm::GetElementPtrInst* gepInstPtr = gepInst;
        const llvm::GetElementPtrInst* gepFactPtr = gepFact;
        do {
          bool isEqual = DataFlowUtils::isGEPInstEqual(gepInstPtr, gepFactPtr);
          if (!isEqual) break;

          // If operand pointer was alloca instruction we are done
          bool isFinal = llvm::isa<llvm::AllocaInst>(gepInstPtr->getPointerOperand());
          if (isFinal) {
            it = facts.erase(it);
            isIteratorIncremented = true;
            break;
          }

          // Continue with inner GEP
          gepInstPtr = llvm::cast<llvm::GetElementPtrInst>(gepInstPtr->getPointerOperand());
          gepFactPtr = llvm::cast<llvm::GetElementPtrInst>(gepFactPtr->getPointerOperand());
        } while (true);
      }
    }
    if (!isIteratorIncremented) ++it;
  }
}

static void
removeBitCastMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::BitCastInst* bitCastInst) {
  for (auto it = facts.begin(); it != facts.end(); ) {
    const auto fact = *it;
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      if (const auto bitCastFact = llvm::dyn_cast<llvm::BitCastInst>(storeFact->getPointerOperand())) {
        const auto allocaFact = bitCastFact->getOperand(0);
        const auto allocaInst = bitCastInst->getOperand(0);
        bool isEqual = allocaFact == allocaInst;
        if (isEqual) {
          it = facts.erase(it);
          continue;
        }
      }
    }
    ++it;
  }
}

void
DataFlowFacts::removeMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::Value* memLocation) {
  /*
   * If memory location is alloca instruction we need to find the corresponding store
   * instruction in the facts set.
   */
  if (const auto allocaMemLocation = llvm::dyn_cast<llvm::AllocaInst>(memLocation)) {
    removeAllocaMemoryLocation(facts, allocaMemLocation);
  }
  /*
   * If memory location is a GEP instruction we cannot use erase on the set instance
   * as this works based on object references. Instead we have to iterate all facts
   * and remove the GEP instruction that is pointing to the store instruction's
   * memory location.
   */
  else if (const auto gepMemLocation = llvm::dyn_cast<llvm::GetElementPtrInst>(memLocation)) {
    removeGEPMemoryLocation(facts, gepMemLocation);
  }
  /*
   * Find the store instructions holding bitcast that points to same alloca instruction
   * as our memLocation
   */
  else if (const auto bitCastMemLocation = llvm::dyn_cast<llvm::BitCastInst>(memLocation)) {
    removeBitCastMemoryLocation(facts, bitCastMemLocation);
  }
  else {
    throw std::runtime_error("We got a memory location of an unknown type -- Did we miss sth.?");
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
