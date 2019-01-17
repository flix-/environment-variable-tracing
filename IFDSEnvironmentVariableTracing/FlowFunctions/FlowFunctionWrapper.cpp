#include "FlowFunctionWrapper.h"

#include "../Utils/DataFlowUtils.h"

namespace psr {

std::set<ExtendedValue>
FlowFunctionWrapper::computeTargets(ExtendedValue fact) {
  bool isBranchOrSwitchFact = llvm::isa<llvm::BranchInst>(fact.getValue()) ||
                              llvm::isa<llvm::SwitchInst>(fact.getValue());
  if (isBranchOrSwitchFact) {
    /*
     * We are inside a tainted block... If we get an instruction that ends
     * it, kill branch fact.
     */
    bool isEndOfTaintedBlock = DataFlowUtils::isEndOfBranchOrSwitchInst(fact, currentInst);
    if (isEndOfTaintedBlock) return { };

    /*
     * Do not add more deeply nested branch/switch statements here.
     */
    bool isBranchOrSwitchInst = llvm::isa<llvm::BranchInst>(currentInst) ||
                                llvm::isa<llvm::SwitchInst>(currentInst);
    if (!isBranchOrSwitchInst) {
      ExtendedValue ev(currentInst);

      if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(currentInst)) {
        ev.setMemLocationSeq(DataFlowUtils::getMemoryLocationSeqFromMatr(storeInst->getPointerOperand()));
      }

      lineNumberStore.addLineNumber(currentInst);

      return { fact, ev };
    }
    return { fact };
  }

  return computeTargetsExt(currentInst, fact, lineNumberStore, zeroValue);
}

} // namespace
