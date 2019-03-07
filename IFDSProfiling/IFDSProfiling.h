/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#ifndef IFDSPROFILING_H
#define IFDSPROFILING_H

#include <phasar/PhasarLLVM/Plugins/Interfaces/IfdsIde/IFDSTabulationProblemPluginExtendedValue.h>

namespace psr {

class IFDSProfiling : public IFDSTabulationProblemPluginExtendedValue {
public:
  IFDSProfiling(LLVMBasedICFG& icfg,
                std::vector<std::string> entryPoints);
  ~IFDSProfiling() override = default;

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
                  SolverResults<const llvm::Instruction*, ExtendedValue, BinaryDomain> &SR) override;

private:
  std::map<std::string, unsigned long long> functionCallCount;
  std::map<std::string, unsigned long long> functionSwitchCount;
};

} // namespace

#endif // IFDSPROFILING_H
