/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef BRANCHSWITCHINSTFLOWFUNCTION_H
#define BRANCHSWITCHINSTFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class BranchSwitchInstFlowFunction : public FlowFunctionBase {

public:
  BranchSwitchInstFlowFunction(const llvm::Instruction* _currentInst,
                               LineNumberStore& _lineNumberStore,
                               ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~BranchSwitchInstFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // BRANCHSWITCHINSTFLOWFUNCTION_H
