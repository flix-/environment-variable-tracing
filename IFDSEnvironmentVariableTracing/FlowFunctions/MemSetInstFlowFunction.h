/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef MEMSETINSTFLOWFUNCTION_H
#define MEMSETINSTFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class MemSetInstFlowFunction : public FlowFunctionBase {

public:
  MemSetInstFlowFunction(const llvm::Instruction* _currentInst,
                         LineNumberStore& _lineNumberStore,
                         ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~MemSetInstFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // MEMSETINSTFLOWFUNCTION_H
