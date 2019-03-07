/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#include "IFDSFunctionStats.h"

#include <fstream>
#include <vector>

#include <llvm/Support/raw_ostream.h>

#include <phasar/PhasarLLVM/IfdsIde/FlowFunctions/Identity.h>

#include <phasar/PhasarLLVM/ControlFlow/LLVMBasedICFG.h>

namespace psr {

std::unique_ptr<IFDSTabulationProblemPluginExtendedValue>
makeIFDSFunctionStats(LLVMBasedICFG& icfg,
                      std::vector<std::string> entryPoints) {

  return std::unique_ptr<IFDSTabulationProblemPluginExtendedValue>(new IFDSFunctionStats(icfg, entryPoints));
}

__attribute__((constructor)) void init() {

  IFDSTabulationProblemPluginExtendedValueFactory["IFDSFunctionStats"] = &makeIFDSFunctionStats;
}

__attribute__((destructor)) void fini() { }

IFDSFunctionStats::IFDSFunctionStats(LLVMBasedICFG& icfg,
                                     std::vector<std::string> entryPoints)
    : IFDSTabulationProblemPluginExtendedValue(icfg, entryPoints) {

  this->solver_config.computeValues = false;
  this->solver_config.computePersistedSummaries = false;
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSFunctionStats::getNormalFlowFunction(const llvm::Instruction* currentInst,
                                         const llvm::Instruction* successorInst) {

  struct FF : public FlowFunction<ExtendedValue> {
    FF(const llvm::Instruction* _currentInst,
       std::map<std::string, unsigned long long>& _functionInstructionCount)
      : currentInst(_currentInst),
        functionInstructionCount(_functionInstructionCount) { }

    std::set<ExtendedValue> computeTargets(ExtendedValue source) {

      const auto functionName = currentInst->getParent()->getParent()->getName();
      const auto& fnInstCount = functionInstructionCount.find(functionName);

      if (fnInstCount != functionInstructionCount.end()) {
        fnInstCount->second++;
      }
      else {
        functionInstructionCount.insert(std::make_pair(functionName, 1));
      }

      return { };
    }

    const llvm::Instruction* currentInst;
    std::map<std::string, unsigned long long>& functionInstructionCount;
  };

  return std::make_shared<FF>(currentInst, functionInstructionCount);
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSFunctionStats::getCallFlowFunction(const llvm::Instruction* callStmt,
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
IFDSFunctionStats::getRetFlowFunction(const llvm::Instruction* callSite,
                                      const llvm::Function* calleeMthd,
                                      const llvm::Instruction* exitStmt,
                                      const llvm::Instruction* retSite) {

  return Identity<ExtendedValue>::getInstance();
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSFunctionStats::getCallToRetFlowFunction(const llvm::Instruction* callSite,
                                            const llvm::Instruction* retSite,
                                            std::set<const llvm::Function*> callees) {

  return Identity<ExtendedValue>::getInstance();
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSFunctionStats::getSummaryFlowFunction(const llvm::Instruction* callStmt,
                                          const llvm::Function* destMthd) {

  return nullptr;
}

std::map<const llvm::Instruction*, std::set<ExtendedValue>>
IFDSFunctionStats::initialSeeds() {

  std::map<const llvm::Instruction*, std::set<ExtendedValue>> seedMap;

  for (const auto& entryPoint : this->EntryPoints) {
    seedMap.insert(std::make_pair(&icfg.getMethod(entryPoint)->front().front(),
                                  std::set<ExtendedValue>({ zeroValue() })));
  }

  return seedMap;
}

void
IFDSFunctionStats::printIFDSReport(std::ostream& os,
                                   SolverResults<const llvm::Instruction*, ExtendedValue, BinaryDomain> &SR) {

  const auto functionCallFile = "stats-function-call-count.csv";
  const auto functionInstructionFile = "stats-function-instruction-count.csv";
  const auto functionAggregateFile = "stats-function-aggregate-count.csv";

  std::ofstream writer(functionCallFile);

  for (const auto& fnCallCountEntry : functionCallCount) {
    const auto function = fnCallCountEntry.first;
    const auto count = fnCallCountEntry.second;

    writer << function << "," << count << "\n";
  }

  writer.close();
  writer.clear();

  writer.open(functionInstructionFile);

  for (const auto& fnInstCountEntry : functionInstructionCount) {
    const auto function = fnInstCountEntry.first;
    const auto count = fnInstCountEntry.second;

    writer << function << "," << count << "\n";
  }

  writer.close();
  writer.clear();

  writer.open(functionAggregateFile);

  for (const auto& fnInstCountEntry : functionInstructionCount) {
    const auto function = fnInstCountEntry.first;
    const auto instCount = fnInstCountEntry.second;

    unsigned long long aggregateCount = instCount;

    const auto fnCallCountEntry = functionCallCount.find(function);
    if (fnCallCountEntry != functionCallCount.end()) {
      const auto callCount = fnCallCountEntry->second;

      aggregateCount = callCount * instCount;
    }

    writer << function << "," << aggregateCount << "\n";
  }
}

} // namespace
