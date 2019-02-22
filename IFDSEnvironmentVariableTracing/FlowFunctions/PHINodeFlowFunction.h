/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef PHINODELOWFUNCTION_H
#define PHINODELOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class PHINodeFlowFunction : public FlowFunctionBase {

public:
  PHINodeFlowFunction(const llvm::Instruction* _currentInst,
                      LineNumberStore& _lineNumberStore,
                      ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~PHINodeFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // PHINODELOWFUNCTION_H
