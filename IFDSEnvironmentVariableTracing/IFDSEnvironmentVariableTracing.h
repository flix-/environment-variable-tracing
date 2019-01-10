#ifndef IFDSENVIRONMENTVARIABLETRACING_H
#define IFDSENVIRONMENTVARIABLETRACING_H

#include "LineNumberStore.h"
//#include "Utils/LLVMIRDump.h"

#include <stack>
#include <map>

#include <phasar/PhasarLLVM/Plugins/Interfaces/IfdsIde/IFDSTabulationProblemPlugin.h>

namespace psr {

class IFDSEnvironmentVariableTracing
    : public IFDSTabulationProblemPlugin {
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

  void
  printReport() override;

private:
  LineNumberStore lineNumberStore;
  std::stack<std::map<const llvm::Value*, const llvm::Value*>> argumentMappingFrames;
  //LLVMIRDump llvmIRDump;

  std::map<const llvm::Value*, const llvm::Value*>&
  getCurrentArgumentMappingFrame() {
    return argumentMappingFrames.top();
  }

  void
  pushArgumentMappingFrame() {
    argumentMappingFrames.push(std::map<const llvm::Value*, const llvm::Value*>());
  }

  void
  popArgumentMappingFrame() {
    argumentMappingFrames.pop();
  }
};

} // namespace

#endif // IFDSENVIRONMENTVARIABLETRACING_H
