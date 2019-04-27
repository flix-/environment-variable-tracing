/**
  * @author Sebastian Roland <seroland86@gmail.com>
  */

#ifndef CHECKOPERANDSFLOWFUNCTION_H
#define CHECKOPERANDSFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class CheckOperandsFlowFunction :
    public FlowFunctionBase
{
public:
  CheckOperandsFlowFunction(const llvm::Instruction* _currentInst,
                            TraceStats& _traceStats,
                            ExtendedValue _zeroValue) :
    FlowFunctionBase(_currentInst, _traceStats, _zeroValue) { }
  ~CheckOperandsFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // CHECKOPERANDSFLOWFUNCTION_H
