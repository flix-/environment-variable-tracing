/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef CHECKOPERANDSFLOWFUNCTION_H
#define CHECKOPERANDSFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class CheckOperandsFlowFunction : public FlowFunctionBase {

public:
  CheckOperandsFlowFunction(const llvm::Instruction* _currentInst,
                            LineNumberStore& _lineNumberStore,
                            ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~CheckOperandsFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // CHECKOPERANDSFLOWFUNCTION_H
