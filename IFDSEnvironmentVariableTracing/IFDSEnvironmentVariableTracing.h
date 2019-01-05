#ifndef IFDSENVIRONMENTVARIABLETRACING_H
#define IFDSENVIRONMENTVARIABLETRACING_H

#include <phasar/PhasarLLVM/Plugins/Interfaces/IfdsIde/IFDSTabulationProblemPlugin.h>

namespace psr {

class IFDSEnvironmentVariableTracing : public IFDSTabulationProblemPlugin {
public:
  IFDSEnvironmentVariableTracing(LLVMBasedICFG& icfg,
                                 std::vector<std::string> entryPoints);
  ~IFDSEnvironmentVariableTracing() override = default;

  std::shared_ptr<FlowFunction<const llvm::Value*>>
  getNormalFlowFunction(const llvm::Instruction* curr,
                        const llvm::Instruction* succ) override;

  std::shared_ptr<FlowFunction<const llvm::Value*>>
  getCallFlowFunction(const llvm::Instruction* callStmt,
                      const llvm::Function* destMthd) override;

  std::shared_ptr<FlowFunction<const llvm::Value*>>
  getRetFlowFunction(const llvm::Instruction* callSite,
                     const llvm::Function* calleeMthd,
                     const llvm::Instruction* exitStmt,
                     const llvm::Instruction* retSite) override;

  std::shared_ptr<FlowFunction<const llvm::Value*>>
  getCallToRetFlowFunction(const llvm::Instruction* callSite,
                           const llvm::Instruction* retSite,
                           std::set<const llvm::Function*> callees) override;

  std::shared_ptr<FlowFunction<const llvm::Value*>>
  getSummaryFlowFunction(const llvm::Instruction* callStmt,
                         const llvm::Function* destMthd) override;

  std::map<const llvm::Instruction*, std::set<const llvm::Value*>>
  initialSeeds() override;
};

} // namespace

#endif // IFDSENVIRONMENTVARIABLETRACING_H
