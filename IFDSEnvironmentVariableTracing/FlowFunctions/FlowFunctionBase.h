/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#ifndef FLOWFUNCTIONBASE_H
#define FLOWFUNCTIONBASE_H

#include "../Stats/TraceStats.h"

#include "../Utils/DataFlowUtils.h"
#include "../Utils/Log.h"

#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunction.h>

namespace psr {

class FlowFunctionBase :
    public FlowFunction<ExtendedValue>
{
public:
  FlowFunctionBase(const llvm::Instruction* _currentInst,
                   TraceStats& _traceStats,
                   ExtendedValue _zeroValue) :
    currentInst(_currentInst),
    traceStats(_traceStats),
    zeroValue(_zeroValue) { }
  ~FlowFunctionBase() override = default;

  std::set<ExtendedValue> computeTargets(ExtendedValue fact) override;
  virtual std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) = 0;

protected:
  const llvm::Instruction* currentInst;
  TraceStats& traceStats;
  ExtendedValue zeroValue;
};

} // namespace

#endif // FLOWFUNCTIONBASE_H
