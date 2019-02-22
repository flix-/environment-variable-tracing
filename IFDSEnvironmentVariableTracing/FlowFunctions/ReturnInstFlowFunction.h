/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef RETURNINSTFLOWFUNCTION_H
#define RETURNINSTFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class ReturnInstFlowFunction : public FlowFunctionBase {

public:
  ReturnInstFlowFunction(const llvm::Instruction* _currentInst,
                         LineNumberStore& _lineNumberStore,
                         ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~ReturnInstFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // RETURNINSTFLOWFUNCTION_H
