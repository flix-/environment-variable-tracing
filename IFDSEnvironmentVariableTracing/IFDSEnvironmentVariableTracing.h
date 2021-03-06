/**
  * @author Sebastian Roland <seroland86@gmail.com>
  */

#ifndef IFDSENVIRONMENTVARIABLETRACING_H
#define IFDSENVIRONMENTVARIABLETRACING_H

#include "Stats/TraceStats.h"

#include <phasar/PhasarLLVM/Plugins/Interfaces/IfdsIde/IFDSTabulationProblemPluginExtendedValue.h>

namespace psr {

class IFDSEnvironmentVariableTracing :
    public IFDSTabulationProblemPluginExtendedValue
{
public:
  IFDSEnvironmentVariableTracing(LLVMBasedICFG& icfg,
                                 std::vector<std::string> entryPoints);
  ~IFDSEnvironmentVariableTracing() override = default;

  std::shared_ptr<FlowFunction<ExtendedValue>>
  getNormalFlowFunction(const llvm::Instruction* curr,
                        const llvm::Instruction* succ) override;

  std::shared_ptr<FlowFunction<ExtendedValue>>
  getCallFlowFunction(const llvm::Instruction* callStmt,
                      const llvm::Function* destMthd) override;

  std::shared_ptr<FlowFunction<ExtendedValue>>
  getRetFlowFunction(const llvm::Instruction* callSite,
                     const llvm::Function* calleeMthd,
                     const llvm::Instruction* exitStmt,
                     const llvm::Instruction* retSite) override;

  std::shared_ptr<FlowFunction<ExtendedValue>>
  getCallToRetFlowFunction(const llvm::Instruction* callSite,
                           const llvm::Instruction* retSite,
                           std::set<const llvm::Function*> callees) override;

  std::shared_ptr<FlowFunction<ExtendedValue>>
  getSummaryFlowFunction(const llvm::Instruction* callStmt,
                         const llvm::Function* destMthd) override;

  std::map<const llvm::Instruction*, std::set<ExtendedValue>>
  initialSeeds() override;

  void
  printIFDSReport(std::ostream& os,
                  SolverResults<const llvm::Instruction*, ExtendedValue, BinaryDomain>& solverResults) override;

private:
  const std::set<std::string> taintedFunctions;
  const std::set<std::string> blacklistedFunctions;

  TraceStats traceStats;
};

} // namespace

#endif // IFDSENVIRONMENTVARIABLETRACING_H
