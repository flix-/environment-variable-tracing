/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef VAENDINSTFLOWFUNCTION_H
#define VAENDINSTFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class VAEndInstFlowFunction : public FlowFunctionBase {

public:
  VAEndInstFlowFunction(const llvm::Instruction* _currentInst,
                        LineNumberStore& _lineNumberStore,
                        ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~VAEndInstFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // VAENDINSTFLOWFUNCTION_H
