/**
  * @author Sebastian Roland <seroland86@gmail.com>
  */

#ifndef MAPTAINTEDVALUESTOCALLER_H
#define MAPTAINTEDVALUESTOCALLER_H

#include "../Stats/TraceStats.h"

#include <llvm/IR/Instructions.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunction.h>
#include <phasar/PhasarLLVM/IfdsIde/LLVMZeroValue.h>

namespace psr {

class MapTaintedValuesToCaller :
    public FlowFunction<ExtendedValue>
{
public:
  MapTaintedValuesToCaller(const llvm::CallInst* _callInst,
                           const llvm::ReturnInst* _retInst,
                           TraceStats& _traceStats,
                           ExtendedValue _zeroValue) :
    callInst(_callInst),
    retInst(_retInst),
    traceStats(_traceStats),
    zeroValue(_zeroValue) { }
  ~MapTaintedValuesToCaller() override = default;

  std::set<ExtendedValue>
  computeTargets(ExtendedValue fact) override;

private:
  const llvm::CallInst* callInst;
  const llvm::ReturnInst* retInst;
  TraceStats& traceStats;
  ExtendedValue zeroValue;
};

} // namespace

#endif // MAPTAINTEDVALUESTOCALLER_H
