/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef STOREINSTFLOWFUNCTION_H
#define STOREINSTFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class StoreInstFlowFunction : public FlowFunctionBase {

public:
  StoreInstFlowFunction(const llvm::Instruction* _currentInst,
                        LineNumberStore& _lineNumberStore,
                        ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _lineNumberStore, _zeroValue) { }
  ~StoreInstFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // STOREINSTFLOWFUNCTION_H
