/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef VASTARTINSTFLOWFUNCTION_H
#define VASTARTINSTFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class VAStartInstFlowFunction : public FlowFunctionBase {

public:
  VAStartInstFlowFunction(const llvm::Instruction* _currentInst,
                          LineNumberStore& _lineNumberStore,
                          ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~VAStartInstFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // VASTARTINSTFLOWFUNCTION_H
