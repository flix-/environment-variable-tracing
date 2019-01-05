#include "IFDSEnvironmentVariableTracing.h"

#include <iostream>

#include <llvm/Support/raw_ostream.h>

#include <phasar/PhasarLLVM/ControlFlow/LLVMBasedICFG.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunctions/Gen.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunctions/Identity.h>

namespace psr {

std::unique_ptr<IFDSTabulationProblemPlugin>
makeIFDSEnvironmentVariableTracing(LLVMBasedICFG& icfg,
                                   std::vector<std::string> entryPoints) {
  return std::unique_ptr<IFDSTabulationProblemPlugin>(new IFDSEnvironmentVariableTracing(icfg, entryPoints));
}

__attribute__((constructor)) void init() {
  llvm::outs() << "init - makeIFDSEnvironmentVariableTracing" << "\n";
  IFDSTabulationProblemPluginFactory["IFDSEnvironmentVariableTracing"] = &makeIFDSEnvironmentVariableTracing;
}

__attribute__((destructor)) void fini() {
  llvm::outs() << "fini - makeIFDSEnvironmentVariableTracing" << "\n";
}

IFDSEnvironmentVariableTracing::IFDSEnvironmentVariableTracing(LLVMBasedICFG& icfg,
                                                               std::vector<std::string> entryPoints)
    : IFDSTabulationProblemPlugin(icfg, entryPoints) {}

std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getNormalFlowFunction(const llvm::Instruction* curr,
                                                      const llvm::Instruction* succ) {
  llvm::outs() << "IFDSEnvironmentVariableTracing::getNormalFlowFunction()" << "\n";

  return Identity<const llvm::Value*>::getInstance();
}

std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getCallFlowFunction(const llvm::Instruction* callStmt,
                                                    const llvm::Function* destMthd) {
  llvm::outs() << "IFDSEnvironmentVariableTracing::getCallFlowFunction()" << "\n";

  return Identity<const llvm::Value*>::getInstance();
}

std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getRetFlowFunction(const llvm::Instruction* callSite,
                                                   const llvm::Function* calleeMthd,
                                                   const llvm::Instruction* exitStmt,
                                                   const llvm::Instruction* retSite) {
  llvm::outs() << "IFDSEnvironmentVariableTracing::getRetFlowFunction()" << "\n";

  return Identity<const llvm::Value*>::getInstance();
}

std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getCallToRetFlowFunction(const llvm::Instruction* callSite,
                                                         const llvm::Instruction* retSite,
                                                         std::set<const llvm::Function*> callees) {
  llvm::outs() << "IFDSEnvironmentVariableTracing::getCallToRetFlowFunction()" << "\n";

  return Identity<const llvm::Value *>::getInstance();
}

std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getSummaryFlowFunction(const llvm::Instruction* callStmt,
                                                       const llvm::Function* destMthd) {
  llvm::outs() << "IFDSEnvironmentVariableTracing::getSummaryFlowFunction()" << "\n";

  return nullptr;
}

std::map<const llvm::Instruction*, std::set<const llvm::Value*>>
IFDSEnvironmentVariableTracing::initialSeeds() {
  llvm::outs() << "IFDSEnvironmentVariableTracing::initialSeeds()" << "\n";

  std::map<const llvm::Instruction*, std::set<const llvm::Value*>> seedMap;
  for (auto &entryPoint : this->EntryPoints) {
    seedMap.insert(std::make_pair(&icfg.getMethod(entryPoint)->front().front(), std::set<const llvm::Value*>({zeroValue()})));
  }
  return seedMap;
}

} // namespace
