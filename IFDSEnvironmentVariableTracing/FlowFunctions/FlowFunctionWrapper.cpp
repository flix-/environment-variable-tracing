#include "FlowFunctionWrapper.h"

#include "../Utils/DataFlowUtils.h"

namespace psr {

std::set<ExtendedValue>
FlowFunctionWrapper::computeTargets(ExtendedValue fact) {

  bool isBranchOrSwitchFact = llvm::isa<llvm::BranchInst>(fact.getValue()) ||
                              llvm::isa<llvm::SwitchInst>(fact.getValue());

  if (isBranchOrSwitchFact) {
    std::string basicBlockLabel = DataFlowUtils::getBBLabel(currentInst);

    bool isEndOfTaintedBlock = basicBlockLabel == fact.getEndOfTaintedBlockLabel();
    if (isEndOfTaintedBlock) return { };

    bool genFact = DataFlowUtils::isTemporaryInst(currentInst);
    if (genFact) {
      lineNumberStore.addLineNumber(currentInst);
      return { fact, ExtendedValue(currentInst) };
    }

    /*
     * Handle all instructions here that generate memory locations (store
     * instructions). Note that we cannot prevent killing of facts as
     * all other facts except the branch one do not know that they are
     * in a tainted block. Problem of distributivity...
     */
    if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(currentInst)) {
      ExtendedValue ev(currentInst);
      ev.setMemLocationSeq(DataFlowUtils::getMemoryLocationSeqFromMatr(storeInst->getPointerOperand()));

      lineNumberStore.addLineNumber(currentInst);

      return { fact, ev };
    }

    return { fact };
  }

  return computeTargetsExt(currentInst, fact, lineNumberStore, zeroValue);
}

} // namespace
