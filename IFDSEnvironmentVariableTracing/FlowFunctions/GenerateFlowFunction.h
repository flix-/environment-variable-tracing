/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef GENERATEFLOWFUNCTION_H
#define GENERATEFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class GenerateFlowFunction : public FlowFunctionBase {

public:
  GenerateFlowFunction(const llvm::Instruction* _currentInst,
                       LineNumberStore& _lineNumberStore,
                       ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~GenerateFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // GENERATEFLOWFUNCTION_H
