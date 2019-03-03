/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#ifndef VASTARTINSTFLOWFUNCTION_H
#define VASTARTINSTFLOWFUNCTION_H

#include "FlowFunctionBase.h"

namespace psr {

class VAStartInstFlowFunction : public FlowFunctionBase {

public:
  VAStartInstFlowFunction(const llvm::Instruction* _currentInst,
                          TraceStats& _traceStats,
                          ExtendedValue _zeroValue)
    : FlowFunctionBase(_currentInst, _traceStats, _zeroValue) { }
  ~VAStartInstFlowFunction() override = default;

  std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) override;
};

} // namespace

#endif // VASTARTINSTFLOWFUNCTION_H
