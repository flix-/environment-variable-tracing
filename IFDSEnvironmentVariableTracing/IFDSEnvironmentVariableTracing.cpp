/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "IFDSEnvironmentVariableTracing.h"

#include "LineNumberStore.h"

#include "FlowFunctions/StoreInstFlowFunction.h"
#include "FlowFunctions/BranchSwitchInstFlowFunction.h"
#include "FlowFunctions/GEPInstFlowFunction.h"
#include "FlowFunctions/PHINodeFlowFunction.h"
#include "FlowFunctions/CheckOperandsFlowFunction.h"
#include "FlowFunctions/ReturnInstFlowFunction.h"
#include "FlowFunctions/CallToRetFlowFunction.h"
#include "FlowFunctions/MemTransferInstFlowFunction.h"
#include "FlowFunctions/MemSetInstFlowFunction.h"
#include "FlowFunctions/VAStartInstFlowFunction.h"
#include "FlowFunctions/VAEndInstFlowFunction.h"

#include "FlowFunctions/IdentityFlowFunction.h"
#include "FlowFunctions/GenerateFlowFunction.h"

#include "FlowFunctions/MapTaintedValuesToCallee.h"
#include "FlowFunctions/MapTaintedValuesToCaller.h"

#include "Utils/DataFlowUtils.h"

#include <fstream>
#include <set>
#include <vector>

#include <llvm/IR/Instructions.h>
#include <llvm/IR/IntrinsicInst.h>

#include <llvm/Support/raw_ostream.h>

#include <phasar/PhasarLLVM/ControlFlow/LLVMBasedICFG.h>

namespace psr {

static const std::set<std::string> TAINTED_CALLS = {
                                                     "getenv",
                                                     "secure_getenv"
                                                   };

static const std::set<std::string> BLACKLISTED_CALLS = {
                                                         "BIO_printf",
                                                         "BIO_vprintf",
                                                         "BIO_snprintf",
                                                         "BIO_vsnprintf",
                                                         "ERR_add_error_data",
                                                         "OPENSSL_showfatal",
                                                       };

std::unique_ptr<IFDSTabulationProblemPluginExtendedValue>
makeIFDSEnvironmentVariableTracing(LLVMBasedICFG& icfg,
                                   std::vector<std::string> entryPoints) {

  return std::unique_ptr<IFDSTabulationProblemPluginExtendedValue>(new IFDSEnvironmentVariableTracing(icfg, entryPoints));
}

__attribute__((constructor)) void init() {

  IFDSTabulationProblemPluginExtendedValueFactory["IFDSEnvironmentVariableTracing"] = &makeIFDSEnvironmentVariableTracing;
}

__attribute__((destructor)) void fini() { }

IFDSEnvironmentVariableTracing::IFDSEnvironmentVariableTracing(LLVMBasedICFG& icfg,
                                                               std::vector<std::string> entryPoints)
    : IFDSTabulationProblemPluginExtendedValue(icfg, entryPoints) {

  this->solver_config.computeValues = false;
  this->solver_config.computePersistedSummaries = false;
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSEnvironmentVariableTracing::getNormalFlowFunction(const llvm::Instruction* currentInst,
                                                      const llvm::Instruction* successorInst) {

  if (llvm::isa<llvm::StoreInst>(currentInst))
    return std::make_shared<StoreInstFlowFunction>(currentInst, lineNumberStore, zeroValue());

  if (llvm::isa<llvm::BranchInst>(currentInst) || llvm::isa<llvm::SwitchInst>(currentInst))
    return std::make_shared<BranchSwitchInstFlowFunction>(currentInst, lineNumberStore, zeroValue());

  if (llvm::isa<llvm::GetElementPtrInst>(currentInst))
    return std::make_shared<GEPInstFlowFunction>(currentInst, lineNumberStore, zeroValue());

  if (llvm::isa<llvm::PHINode>(currentInst))
    return std::make_shared<PHINodeFlowFunction>(currentInst, lineNumberStore, zeroValue());

  if (DataFlowUtils::isCheckOperandsInst(currentInst))
    return std::make_shared<CheckOperandsFlowFunction>(currentInst, lineNumberStore, zeroValue());

  if (llvm::isa<llvm::ReturnInst>(successorInst))
    return std::make_shared<ReturnInstFlowFunction>(successorInst, lineNumberStore, zeroValue());

  return std::make_shared<IdentityFlowFunction>(currentInst, lineNumberStore, zeroValue());
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSEnvironmentVariableTracing::getCallFlowFunction(const llvm::Instruction* callStmt,
                                                    const llvm::Function* destMthd) {

  return std::make_shared<MapTaintedValuesToCallee>(llvm::cast<llvm::CallInst>(callStmt),
                                                    destMthd,
                                                    lineNumberStore,
                                                    zeroValue());
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSEnvironmentVariableTracing::getRetFlowFunction(const llvm::Instruction* callSite,
                                                   const llvm::Function* calleeMthd,
                                                   const llvm::Instruction* exitStmt,
                                                   const llvm::Instruction* retSite) {

  return std::make_shared<MapTaintedValuesToCaller>(llvm::cast<llvm::CallInst>(callSite),
                                                    llvm::cast<llvm::ReturnInst>(exitStmt),
                                                    lineNumberStore,
                                                    zeroValue());
}

/*
 * Every fact that was valid before call to function will be handled here
 * right after the function call has returned... We would like to keep all
 * previously generated facts. Facts from the returning functions are
 * handled in getRetFlowFunction.
 */
std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSEnvironmentVariableTracing::getCallToRetFlowFunction(const llvm::Instruction* callSite,
                                                         const llvm::Instruction* retSite,
                                                         std::set<const llvm::Function*> callees) {

  /*
   * It is important to wrap the identity call here. Consider the following example:
   *
   * br i1 %cmp, label %cond.true, label %cond.false
   * cond.true:
   *   %call1 = call i32 (...) @foo()
   *   br label %cond.end
   * ...
   * cond.end:
   * %cond = phi i32 [ %call1, %cond.true ], [ 1, %cond.false ]
   *
   * Because we are in a tainted branch we must push %call1 to facts. We cannot do that
   * in the getSummaryFlowFunction() because if we return a flow function we never follow
   * the function. If we intercept here the call instruction will be pushed when the flow
   * function is called with the branch instruction fact.
   */
  return std::make_shared<CallToRetFlowFunction>(callSite, lineNumberStore, zeroValue());
}

/*
 * If we return sth. different than a nullptr the callee will not be traversed. Instead
 * facts according to the defined flow function will be taken into account.
 */
std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSEnvironmentVariableTracing::getSummaryFlowFunction(const llvm::Instruction* callStmt,
                                                       const llvm::Function* destMthd) {

  const auto destMthdName = destMthd->getName();

  /*
   * We exclude function ptr calls as they will be applied to every
   * function matching its signature (@see LLVMBasedICFG.cpp:217).
   */
  const auto callInst = llvm::cast<llvm::CallInst>(callStmt);
  bool isStaticCallSite = callInst->getCalledFunction();
  if (!isStaticCallSite)
    return std::make_shared<IdentityFlowFunction>(callStmt, lineNumberStore, zeroValue());

  /*
   * Exclude blacklisted functions here.
   */
  bool isBlackListedCall = BLACKLISTED_CALLS.find(destMthdName) != BLACKLISTED_CALLS.end();
  if (isBlackListedCall)
    return std::make_shared<IdentityFlowFunction>(callStmt, lineNumberStore, zeroValue());

  /*
   * Intrinsics.
   */
  if (llvm::isa<llvm::MemTransferInst>(callStmt))
    return std::make_shared<MemTransferInstFlowFunction>(callStmt, lineNumberStore, zeroValue());

  if (llvm::isa<llvm::MemSetInst>(callStmt))
    return std::make_shared<MemSetInstFlowFunction>(callStmt, lineNumberStore, zeroValue());

  if (llvm::isa<llvm::VAStartInst>(callStmt))
    return std::make_shared<VAStartInstFlowFunction>(callStmt, lineNumberStore, zeroValue());

  if (llvm::isa<llvm::VAEndInst>(callStmt))
    return std::make_shared<VAEndInstFlowFunction>(callStmt, lineNumberStore, zeroValue());

  /*
   * Provide summary for tainted calls.
   */
  bool isTaintedCall = TAINTED_CALLS.find(destMthdName) != TAINTED_CALLS.end();
  if (isTaintedCall)
    return std::make_shared<GenerateFlowFunction>(callStmt, lineNumberStore, zeroValue());

  /*
   * Skip all (other) declarations.
   */
  bool isDeclaration = destMthd->isDeclaration();
  if (isDeclaration)
    return std::make_shared<IdentityFlowFunction>(callStmt, lineNumberStore, zeroValue());

  /*
   * Follow call -> getCallFlowFunction()
   */
  return nullptr;
}

std::map<const llvm::Instruction*, std::set<ExtendedValue>>
IFDSEnvironmentVariableTracing::initialSeeds() {

  std::map<const llvm::Instruction*, std::set<ExtendedValue>> seedMap;

  for (const auto& entryPoint : this->EntryPoints) {
    seedMap.insert(std::make_pair(&icfg.getMethod(entryPoint)->front().front(),
                                  std::set<ExtendedValue>({ zeroValue() })));
  }

  return seedMap;
}

void
IFDSEnvironmentVariableTracing::printIFDSReport(std::ostream& os,
                                                SolverResults<const llvm::Instruction*, ExtendedValue, BinaryDomain> &SR) {

  /*
   * 1) Simple report for tests (compatibility)
   * 2) lcov trace file
   */
  const std::string simpleReportFile = "line-numbers.txt";
  const std::string lcovTraceFile = DataFlowUtils::getTraceFilename(EntryPoints.front());

  // Write simple report
  std::ofstream writer(simpleReportFile);

  llvm::outs() << "Writing simple report to: " << simpleReportFile << "\n";

  for (const auto& pair : lineNumberStore.getLineNumbers()) {
    const auto lineNumbers = pair.second;

    for (const auto& lineNumber : lineNumbers) {
      writer << lineNumber << "\n";
    }
  }
  writer.close();
  writer.clear();

  // Write lcov trace
  writer.open(lcovTraceFile);

  llvm::outs() << "Writing lcov trace to: " << lcovTraceFile << "\n";

  for (const auto& pair : lineNumberStore.getLineNumbers()) {
    const auto path = pair.first;
    const auto lineNumbers = pair.second;

    writer << "SF:" << path << "\n";

    for (const auto& lineNumber : lineNumbers) {
      writer << "DA:" << lineNumber << ",1" << "\n";
    }

    writer << "end_of_record" << "\n";
  }
}

} // namespace
