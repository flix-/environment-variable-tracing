#include "FlowFunctionWrapper.h"

#include "../Utils/DataFlowUtils.h"

namespace psr {

std::set<const llvm::Value*>
FlowFunctionWrapper::computeTargets(const llvm::Value* fact) {
  bool isBranchOrSwitchFact = llvm::isa<llvm::BranchInst>(fact) ||
                              llvm::isa<llvm::SwitchInst>(fact);
  if (isBranchOrSwitchFact) {
    const auto branchOrSwitchFact = fact;
    /*
     * We are inside a tainted block... If we get an instruction that ends
     * it, kill branch fact.
     */
    bool isEndOfTaintedBlock = DataFlowUtils::isEndOfBranchOrSwitchInst(branchOrSwitchFact, currentInst);
    if (isEndOfTaintedBlock) return { };

    /*
     * Do not add more deeply nested branch/switch statements here.
     */
    bool isBranchOrSwitchInst = llvm::isa<llvm::BranchInst>(currentInst) ||
                                llvm::isa<llvm::SwitchInst>(currentInst);
    if (!isBranchOrSwitchInst) {
      lineNumberStore.addLineNumber(currentInst);
      return { fact, currentInst };
    }
    return { fact };
  }
  return computeTargetsExt(currentInst, fact, argumentMappings, lineNumberStore, zeroValue);
}

} // namespace
