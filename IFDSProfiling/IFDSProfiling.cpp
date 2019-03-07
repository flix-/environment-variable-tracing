/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#include "IFDSProfiling.h"

#include <fstream>
#include <sstream>
#include <vector>

#include <llvm/Support/raw_ostream.h>

#include <phasar/PhasarLLVM/IfdsIde/FlowFunctions/Identity.h>

#include <phasar/PhasarLLVM/ControlFlow/LLVMBasedICFG.h>

namespace psr {

std::unique_ptr<IFDSTabulationProblemPluginExtendedValue>
makeIFDSProfiling(LLVMBasedICFG& icfg,
                  std::vector<std::string> entryPoints) {

  return std::unique_ptr<IFDSTabulationProblemPluginExtendedValue>(new IFDSProfiling(icfg, entryPoints));
}

__attribute__((constructor)) void init() {

  IFDSTabulationProblemPluginExtendedValueFactory["IFDSProfiling"] = &makeIFDSProfiling;
}

__attribute__((destructor)) void fini() { }

IFDSProfiling::IFDSProfiling(LLVMBasedICFG& icfg,
                             std::vector<std::string> entryPoints)
    : IFDSTabulationProblemPluginExtendedValue(icfg, entryPoints) {

  this->solver_config.computeValues = false;
  this->solver_config.computePersistedSummaries = false;
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSProfiling::getNormalFlowFunction(const llvm::Instruction* currentInst,
                                     const llvm::Instruction* successorInst) {

  struct FF : public FlowFunction<ExtendedValue> {
    FF(const llvm::Instruction* _currentInst,
       std::map<std::string, unsigned long long>& _functionSwitchCount)
      : currentInst(_currentInst),
        functionSwitchCount(_functionSwitchCount) { }

    std::set<ExtendedValue> computeTargets(ExtendedValue source) {

      if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(currentInst)) {
        const auto functionName = currentInst->getParent()->getParent()->getName();
        const auto& fnSwitchCount = functionSwitchCount.find(functionName);

        if (fnSwitchCount != functionSwitchCount.end()) {
          fnSwitchCount->second++;
        }
        else {
          functionSwitchCount.insert(std::make_pair(functionName, 1));
        }
      }

      return { };
    }

    const llvm::Instruction* currentInst;
    std::map<std::string, unsigned long long>& functionSwitchCount;
  };

  return std::make_shared<FF>(currentInst, functionSwitchCount);
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSProfiling::getCallFlowFunction(const llvm::Instruction* callStmt,
                                   const llvm::Function* destMthd) {

  struct FF : public FlowFunction<ExtendedValue> {
    FF(const llvm::Function* _destMthd,
       std::map<std::string, unsigned long long>& _functionCallCount)
      : destMthd(_destMthd),
        functionCallCount(_functionCallCount) { }

    std::set<ExtendedValue> computeTargets(ExtendedValue source) {

      const auto functionName = destMthd->getName();
      const auto& fnInstCount = functionCallCount.find(functionName);

      if (fnInstCount != functionCallCount.end()) {
        fnInstCount->second++;
      }
      else {
        functionCallCount.insert(std::make_pair(functionName, 1));
      }

      return { };
    }

    const llvm::Function* destMthd;
    std::map<std::string, unsigned long long>& functionCallCount;
  };

  return std::make_shared<FF>(destMthd, functionCallCount);
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSProfiling::getRetFlowFunction(const llvm::Instruction* callSite,
                                  const llvm::Function* calleeMthd,
                                  const llvm::Instruction* exitStmt,
                                  const llvm::Instruction* retSite) {

  return Identity<ExtendedValue>::getInstance();
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSProfiling::getCallToRetFlowFunction(const llvm::Instruction* callSite,
                                        const llvm::Instruction* retSite,
                                        std::set<const llvm::Function*> callees) {

  return Identity<ExtendedValue>::getInstance();
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSProfiling::getSummaryFlowFunction(const llvm::Instruction* callStmt,
                                      const llvm::Function* destMthd) {

  return nullptr;
}

std::map<const llvm::Instruction*, std::set<ExtendedValue>>
IFDSProfiling::initialSeeds() {

  std::map<const llvm::Instruction*, std::set<ExtendedValue>> seedMap;

  for (const auto& entryPoint : this->EntryPoints) {
    seedMap.insert(std::make_pair(&icfg.getMethod(entryPoint)->front().front(),
                                  std::set<ExtendedValue>({ zeroValue() })));
  }

  return seedMap;
}

void
IFDSProfiling::printIFDSReport(std::ostream& os,
                               SolverResults<const llvm::Instruction*, ExtendedValue, BinaryDomain> &SR) {

  const auto profilingOutFile = "profiling-switch-call-aggregate.csv";

  std::ofstream writer(profilingOutFile);

  for (const auto& fnSwitchCountEntry : functionSwitchCount) {
    const auto function = fnSwitchCountEntry.first;
    const auto switchCount = fnSwitchCountEntry.second;

    unsigned long long callCount = 1;

    const auto fnCallCountEntry = functionCallCount.find(function);
    if (fnCallCountEntry != functionCallCount.end()) callCount = fnCallCountEntry->second;

    std::stringstream sstream;
    sstream << function << ",";
    sstream << switchCount << ",";
    sstream << callCount << ",";

    unsigned long long aggregate = switchCount * callCount;

    sstream << aggregate;

    writer << sstream.str() << "\n";
  }
}

} // namespace
