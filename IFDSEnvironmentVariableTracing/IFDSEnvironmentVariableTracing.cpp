#include "IFDSEnvironmentVariableTracing.h"

#include "LineNumberStore.h"
#include "DataFlowFacts.h"
#include "MapTaintedArgsToCallee.h"

#include <iostream>
#include <fstream>

#include <llvm/IR/Constants.h>
#include <llvm/IR/IntrinsicInst.h>

#include <llvm/Support/raw_ostream.h>

#include <phasar/PhasarLLVM/ControlFlow/LLVMBasedICFG.h>

#include <phasar/PhasarLLVM/IfdsIde/FlowFunctions/Identity.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunctions/Gen.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunctions/GenIf.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunctions/Kill.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunctions/KillAll.h>


namespace psr {

static const char* LINE_NUMBERS_OUTPUT_FILE = "line-numbers.txt";
static const char* TAINT_CALL = "getenv";

static LineNumberStore lineNumberStore;

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
    : IFDSTabulationProblemPlugin(icfg, entryPoints)
{
  this->solver_config.computeValues = false;
}

std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getNormalFlowFunction(const llvm::Instruction* currentInst,
                                                      const llvm::Instruction* successorInst) {
  llvm::outs() << "getNormalFlowFunction()" << "\n";
  currentInst->print(llvm::outs()); llvm::outs() << "\n\n";

  /*
   * Load instruction
   */
  if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(currentInst)) {
    llvm::outs() << "Got load instruction" << "\n";

    const auto genLoadFactCondition = [loadInst](const llvm::Value* fact) {
      const auto memLocation = loadInst->getPointerOperand();

      bool isLoadTainted = DataFlowFacts::isValueEqual(fact, memLocation) ||
                           DataFlowFacts::isMemoryLocationEqual(fact, memLocation);

      if (isLoadTainted) lineNumberStore.addLineNumber(loadInst);

      return isLoadTainted;
    };

    return std::make_shared<GenIf<const llvm::Value*>>(loadInst, zeroValue(), genLoadFactCondition);
  }
  /*
   * Store instruction
   */
  else if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(currentInst)) {
    llvm::outs() << "Got store instruction" << "\n";

    struct StoreFlowFunction : public FlowFunction<const llvm::Value*> {
      const llvm::StoreInst* storeInst;
      StoreFlowFunction(const llvm::StoreInst* _storeInst) : storeInst(_storeInst) {}

      std::set<const llvm::Value*>
      computeTargets(const llvm::Value* fact) override {
        const auto value = storeInst->getValueOperand();
        const auto memLocation = storeInst->getPointerOperand();

        // Taint memory location if value is tainted
        bool isValueTainted = DataFlowFacts::isValueEqual(fact, value) ||
                              DataFlowFacts::isMemoryLocationEqual(fact, value);
        if (isValueTainted) {
          lineNumberStore.addLineNumber(storeInst);
          return { fact, storeInst };
        }

        // Kill memory location if value is not tainted but memory location
        bool isMemLocationTainted = DataFlowFacts::isMemoryLocationEqual(fact, memLocation);
        if (isMemLocationTainted) return { };

        return { fact };
      }
    };

    return std::make_shared<StoreFlowFunction>(storeInst);
  }

  return Identity<const llvm::Value*>::getInstance();
}

std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getCallFlowFunction(const llvm::Instruction* callStmt,
                                                    const llvm::Function* destMthd) {
  llvm::outs() << "getCallFlowFunction()" << "\n";
  callStmt->print(llvm::outs()); llvm::outs() << "\n\n";

  const auto callInst = llvm::cast<llvm::CallInst>(callStmt);

  return std::make_shared<MapTaintedArgsToCallee>(callInst, destMthd, zeroValue());
}

std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getRetFlowFunction(const llvm::Instruction* callSite,
                                                   const llvm::Function* calleeMthd,
                                                   const llvm::Instruction* exitStmt,
                                                   const llvm::Instruction* retSite) {
  llvm::outs() << "getRetFlowFunction()" << "\n";

  return Identity<const llvm::Value*>::getInstance();
}

/*
 * Every fact that was valid before call to function will be handled here
 * right after the function call has returned... We would like to keep all
 * previously generated facts. Facts from the returning functions are
 * handled in getRetFlowFunction.
 */
std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getCallToRetFlowFunction(const llvm::Instruction* callSite,
                                                         const llvm::Instruction* retSite,
                                                         std::set<const llvm::Function*> callees) {
  llvm::outs() << "getCallToRetFlowFunction()" << "\n";

  return Identity<const llvm::Value *>::getInstance();
}

/*
 * If we return sth. different than a nullptr the callee will not be traversed. Instead
 * facts according to the defined flow function will be taken into account.
 */
std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getSummaryFlowFunction(const llvm::Instruction* callStmt,
                                                       const llvm::Function* destMthd) {
  llvm::outs() << "getSummaryFlowFunction()" << "\n";
  callStmt->print(llvm::outs()); llvm::outs() << "\n\n";

  /*
   * Add getenv() calls to facts
   */
  bool isTainted = destMthd->getName().compare_lower(TAINT_CALL) == 0;
  if (isTainted) {
    lineNumberStore.addLineNumber(callStmt);
    return std::make_shared<Gen<const llvm::Value*>>(llvm::cast<const llvm::Value>(callStmt), zeroValue());
  }

  bool isLLVMDebugCall = destMthd->getName().contains_lower("llvm.dbg");
  if (isLLVMDebugCall) {
    return KillAll<const llvm::Value*>::getInstance();
  }

  /*
   * Follow call...
   */
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

void
IFDSEnvironmentVariableTracing::printReport() {
  std::ofstream writer(LINE_NUMBERS_OUTPUT_FILE);
  for (const auto lineNumber : lineNumberStore.getLineNumbers()) {
    writer << lineNumber << "\n";
  }
}

} // namespace
