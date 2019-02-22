/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef IDENTITYFLOWFUNCTION_H
#define IDENTITYFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class IdentityFlowFunction : public FlowFunctionBase {

public:
  IdentityFlowFunction(const llvm::Instruction* _currentInst,
                      LineNumberStore& _lineNumberStore,
                      ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~IdentityFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // IDENTITYFLOWFUNCTION_H
