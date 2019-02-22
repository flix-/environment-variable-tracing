/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef CALLTORETFLOWFUNCTION_H
#define CALLTORETFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class CallToRetFlowFunction : public FlowFunctionBase {

public:
  CallToRetFlowFunction(const llvm::Instruction* _currentInst,
                        LineNumberStore& _lineNumberStore,
                        ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~CallToRetFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // CALLTORETFLOWFUNCTION_H
