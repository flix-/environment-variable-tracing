#include "IFDSEnvironmentVariableTracing.h"

#include "LineNumberStore.h"

#include "FlowFunctions/FlowFunctionWrapper.h"
#include "FlowFunctions/Identity.h"
#include "FlowFunctions/MapTaintedArgsToCallee.h"

#include "Utils/DataFlowUtils.h"

#include <fstream>

#include <llvm/IR/Constants.h>
#include <llvm/IR/IntrinsicInst.h>

#include <llvm/Support/raw_ostream.h>

#include <phasar/PhasarLLVM/ControlFlow/LLVMBasedICFG.h>


namespace psr {

static const char* LINE_NUMBERS_OUTPUT_FILE = "line-numbers.txt";
static const char* GETENV_CALL = "getenv";


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
    : IFDSTabulationProblemPlugin(icfg, entryPoints) {

  pushArgumentMappingFrame();
}

std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getNormalFlowFunction(const llvm::Instruction* currentInst,
                                                      const llvm::Instruction* successorInst) {
  llvm::outs() << "getNormalFlowFunction()" << "\n";
  currentInst->print(llvm::outs()); llvm::outs() << "\n\n";

  bool isCheckOperandsInst = llvm::isa<llvm::UnaryInstruction>(currentInst) ||
                             llvm::isa<llvm::BinaryOperator>(currentInst) ||
                             llvm::isa<llvm::CmpInst>(currentInst) ||
                             llvm::isa<llvm::SelectInst>(currentInst);
  /*
   * Load instruction
   */
  if (llvm::isa<llvm::LoadInst>(currentInst)) {
    llvm::outs() << "Got load instruction" << "\n";

    ComputeTargetsExtFunction loadFlowFunction = [](const llvm::Instruction* currentInst,
                                                    const llvm::Value* fact,
                                                    const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                    LineNumberStore& lineNumberStore,
                                                    const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {

      const auto loadInst = llvm::cast<llvm::LoadInst>(currentInst);

      const auto memLocation = loadInst->getPointerOperand();

      bool isLoadTainted = DataFlowUtils::isValueEqual(fact, memLocation) ||
                           DataFlowUtils::isMemoryLocationEqual(fact, memLocation, argumentMappings);

      if (isLoadTainted) {
        lineNumberStore.addLineNumber(loadInst);
        return { fact, loadInst };
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, loadFlowFunction, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
  }
  /*
   * Store instruction
   */
  else if (llvm::isa<llvm::StoreInst>(currentInst)) {
    llvm::outs() << "Got store instruction" << "\n";

    ComputeTargetsExtFunction storeFlowFunction = [](const llvm::Instruction* currentInst,
                                                     const llvm::Value* fact,
                                                     const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                     LineNumberStore& lineNumberStore,
                                                     const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {

      const auto storeInst = llvm::cast<llvm::StoreInst>(currentInst);

      const auto value = storeInst->getValueOperand();
      const auto memLocation = storeInst->getPointerOperand();

      // Patch memory location frame
      bool isValueFunctionArgument = llvm::isa<llvm::Argument>(value);
      if (isValueFunctionArgument) {
        DataFlowUtils::patchMemoryLocationFrame(value, memLocation, const_cast<std::map<const llvm::Value*, const llvm::Value*>&>(argumentMappings));
        return { fact };
      }

      // Taint memory location if value is tainted
      bool isValueTainted = DataFlowUtils::isValueEqual(fact, value) ||
                            DataFlowUtils::isMemoryLocationEqual(fact, value, argumentMappings);
      if (isValueTainted) {
        lineNumberStore.addLineNumber(storeInst);
        return { fact, storeInst };
      }

      // Kill memory location if value is not tainted but memory location
      bool isMemLocationTainted = DataFlowUtils::isMemoryLocationEqual(fact, memLocation, argumentMappings);
      if (isMemLocationTainted) return { };
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, storeFlowFunction, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
  }
  /*
   * Phi node instruction
   */
  else if (llvm::isa<llvm::PHINode>(currentInst)) {
    llvm::outs() << "Got phi node instruction" << "\n";

    ComputeTargetsExtFunction phiNodeFlowFunction = [](const llvm::Instruction* currentInst,
                                                       const llvm::Value* fact,
                                                       const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                       LineNumberStore& lineNumberStore,
                                                       const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {
      const auto phiNodeInst = llvm::cast<llvm::PHINode>(currentInst);

      const auto trueConstant = llvm::ConstantInt::getTrue(phiNodeInst->getContext());
      const auto falseConstant = llvm::ConstantInt::getFalse(phiNodeInst->getContext());

      // If phi node contains at least one tainted value push fact
      for (const auto block : phiNodeInst->blocks()) {
        const auto incomingValue = phiNodeInst->getIncomingValueForBlock(block);
        /*
         * We need special treatment if the value v of the <v, bb> pairs is not an
         * instruction but a constant (true / false). This is necessary to correctly
         * implement the boolean operators && and ||. E.g. the phi node of an || operation
         * looks as follows:
         *
         * %1 = phi i1 [ true, %entry ], [ %tobool2, %lor.rhs ]
         *
         * If the left hand side of the || operation has been a tainted value we cannot identify
         * this fact based on the phi node itself...
         *
         * Whenever we encounter true or false in a <v, bb> pair of a phi node we are backtracking
         * to the basic block and check the branch instruction for a tainted value.
         */
        if (const auto constant = llvm::dyn_cast<llvm::Constant>(incomingValue)) {
          if (constant == trueConstant || constant == falseConstant) {
            const auto terminatorInst = block->getTerminator();

            for (const auto &use : terminatorInst->operands()) {
              bool isTainted = DataFlowUtils::isValueEqual(fact, use.get()) ||
                               DataFlowUtils::isMemoryLocationEqual(fact, use.get(), argumentMappings);
              if (isTainted) {
                lineNumberStore.addLineNumber(phiNodeInst);
                return { fact, phiNodeInst };
              }
            }
          }
        }
        /*
         * If it's not a constant check whether value is tainted...
         */
        else {
          bool isTainted = DataFlowUtils::isValueEqual(fact, incomingValue) ||
                           DataFlowUtils::isMemoryLocationEqual(fact, incomingValue, argumentMappings);
          if (isTainted) {
            lineNumberStore.addLineNumber(phiNodeInst);
            return { fact, phiNodeInst };
          }
        }
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, phiNodeFlowFunction, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
  }
  /*
   * Branch instruction
   */
  else if (llvm::isa<llvm::BranchInst>(currentInst)) {
    llvm::outs() << "Got branch instruction" << "\n";

    ComputeTargetsExtFunction branchFlowFunction = [](const llvm::Instruction* currentInst,
                                                      const llvm::Value* fact,
                                                      const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                      LineNumberStore& lineNumberStore,
                                                      const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {
      const auto branchInst = llvm::cast<llvm::BranchInst>(currentInst);

      bool isConditional = branchInst->isConditional();
      if (isConditional) {
        const auto condition = branchInst->getCondition();

        bool isBranchTainted = DataFlowUtils::isValueEqual(fact, condition);
        if (isBranchTainted) {
          lineNumberStore.addLineNumber(branchInst);
          return { fact, branchInst };
        }
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, branchFlowFunction, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
  }
  /*
   * Switch instruction
   */
  else if (llvm::isa<llvm::SwitchInst>(currentInst)) {
    llvm::outs() << "Got switch instruction" << "\n";

    ComputeTargetsExtFunction switchFlowFunction = [](const llvm::Instruction* currentInst,
                                                      const llvm::Value* fact,
                                                      const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                      LineNumberStore& lineNumberStore,
                                                      const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {
      const auto switchInst = llvm::cast<llvm::SwitchInst>(currentInst);

      const auto condition = switchInst->getCondition();
      /*
       * No need to check memory locations here as it is forbidden to use
       * a memory address as a condition in switch statement.
       */
      bool isSwitchTainted = DataFlowUtils::isValueEqual(fact, condition);
      if (isSwitchTainted) {
        lineNumberStore.addLineNumber(switchInst);
        return { fact, switchInst };
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, switchFlowFunction, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
  }
  /*
   * Operands checking instruction
   */
  else if (isCheckOperandsInst) {
    llvm::outs() << "Got operands checking instruction (" << currentInst->getOpcodeName() << ")" << "\n";

    ComputeTargetsExtFunction checkOperandsFlowFunction = [](const llvm::Instruction* currentInst,
                                                             const llvm::Value* fact,
                                                             const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                             LineNumberStore& lineNumberStore,
                                                             const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {
      for (const auto &use : currentInst->operands()) {
        bool isOperandTainted = DataFlowUtils::isValueEqual(fact, use.get()) ||
                                DataFlowUtils::isMemoryLocationEqual(fact, use.get(), argumentMappings);
        if (isOperandTainted) {
          lineNumberStore.addLineNumber(currentInst);
          return { fact, currentInst };
        }
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, checkOperandsFlowFunction, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
  }

  /*
   * Default: Identity
   */
  return Identity::getInstance(currentInst, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
}

/*
 * This functions MUST only be called when we are following a function. This is crucial
 * to keep the pushes and pops to the argument mapping stack aligned. Disable calls of
 * this function through getSummaryFlowFunction().
 */
std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getCallFlowFunction(const llvm::Instruction* callStmt,
                                                    const llvm::Function* destMthd) {
  llvm::outs() << "getCallFlowFunction()" << "\n";
  callStmt->print(llvm::outs()); llvm::outs() << "\n\n";

  auto& callerArgumentMappings = getCurrentArgumentMappingFrame();

  pushArgumentMappingFrame();

  auto& calleeArgumentMappings = getCurrentArgumentMappingFrame();

  return std::make_shared<MapTaintedArgsToCallee>(llvm::cast<llvm::CallInst>(callStmt),
                                                  destMthd,
                                                  callerArgumentMappings,
                                                  calleeArgumentMappings,
                                                  lineNumberStore,
                                                  zeroValue());
}

std::shared_ptr<FlowFunction<const llvm::Value*>>
IFDSEnvironmentVariableTracing::getRetFlowFunction(const llvm::Instruction* callSite,
                                                   const llvm::Function* calleeMthd,
                                                   const llvm::Instruction* exitStmt,
                                                   const llvm::Instruction* retSite) {
  llvm::outs() << "getRetFlowFunction()" << "\n";

  //popArgumentMappingFrame();

  return Identity::getInstance(callSite, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
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
  ComputeTargetsExtFunction getCallToRetFlowFunction = [](const llvm::Instruction* currentInst,
                                                          const llvm::Value* fact,
                                                          const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                          LineNumberStore& lineNumberStore,
                                                          const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {
    /*
     * For functions that kill facts and are  handled in getSummaryFlowFunction()
     * we kill all facts here and just use what they have returned. This is
     * important e.g. if memset removes a store fact then it is not readded here
     * through the identity function.
     *
     * Need to keep the list in sync with "killing" functions in getSummaryFlowFunction()!
     */
    bool isHandledInSummaryFlowFunction = llvm::isa<llvm::MemTransferInst>(currentInst) ||
                                          llvm::isa<llvm::MemSetInst>(currentInst);
    if (isHandledInSummaryFlowFunction) return { };

    return { fact };
  };

  return std::make_shared<FlowFunctionWrapper>(callSite, getCallToRetFlowFunction, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
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
   * Memcpy / Memmove instruction
   */
  if (llvm::isa<llvm::MemTransferInst>(callStmt)) {
    llvm::outs() << "Got memcpy/memmove instruction" << "\n";

    ComputeTargetsExtFunction memTransferFlowFunction = [](const llvm::Instruction* currentInst,
                                                           const llvm::Value* fact,
                                                           const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                           LineNumberStore& lineNumberStore,
                                                           const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {
      const auto memTransferInst = llvm::cast<const llvm::MemTransferInst>(currentInst);

      const auto srcMemLocation = memTransferInst->getRawSource();
      const auto dstMemLocation = memTransferInst->getRawDest();

      // Taint memory location if src is tainted
      bool isSrcMemLocationTainted = DataFlowUtils::isValueEqual(fact, srcMemLocation) ||
                                     DataFlowUtils::isMemoryLocationEqual(fact, srcMemLocation, argumentMappings);
      if (isSrcMemLocationTainted) {
        lineNumberStore.addLineNumber(memTransferInst);
        return { fact, memTransferInst };
      }

      // Kill memory location if src is not tainted but dst
      bool isDstMemLocationTainted = DataFlowUtils::isMemoryLocationEqual(fact, dstMemLocation, argumentMappings);
      if (isDstMemLocationTainted) return { };
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(callStmt, memTransferFlowFunction, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
  }
  /*
   * Memset instruction
   */
  else if (llvm::isa<llvm::MemSetInst>(callStmt)) {
    llvm::outs() << "Got memset instruction" << "\n";

    ComputeTargetsExtFunction memSetFlowFunction = [](const llvm::Instruction* currentInst,
                                                      const llvm::Value* fact,
                                                      const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                      LineNumberStore& lineNumberStore,
                                                      const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {
      const auto memSetInst = llvm::cast<const llvm::MemSetInst>(currentInst);

      const auto dstMemLocation = memSetInst->getRawDest();

      bool isDstMemLocationTainted = DataFlowUtils::isMemoryLocationEqual(fact, dstMemLocation, argumentMappings);
      if (isDstMemLocationTainted) {
        // Kill memory location
        return { };
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(callStmt, memSetFlowFunction, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
  }

  /*
   * Provide summary for getenv() call
   */
  bool isGetenvCall = destMthd->getName().compare_lower(GETENV_CALL) == 0;
  if (isGetenvCall) {
    ComputeTargetsExtFunction getenvCallFlowFunction = [](const llvm::Instruction* currentInst,
                                                          const llvm::Value* fact,
                                                          const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                          LineNumberStore& lineNumberStore,
                                                          const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {
      lineNumberStore.addLineNumber(currentInst);
      if (fact == zeroValue) return { zeroValue, currentInst };
      return { fact };
    };
    return std::make_shared<FlowFunctionWrapper>(callStmt, getenvCallFlowFunction, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());
  }

  /*
   * Skip all declarations
   */
  bool isDeclaration = destMthd->isDeclaration();
  if (isDeclaration) return Identity::getInstance(callStmt, getCurrentArgumentMappingFrame(), lineNumberStore, zeroValue());

  /*
   * Follow call -> getCallFlowFunction()
   */
  return nullptr;
}

std::map<const llvm::Instruction*, std::set<const llvm::Value*>>
IFDSEnvironmentVariableTracing::initialSeeds() {
  llvm::outs() << "initialSeeds()" << "\n";

  std::map<const llvm::Instruction*, std::set<const llvm::Value*>> seedMap;
  for (auto &entryPoint : this->EntryPoints) {
    seedMap.insert(std::make_pair(&icfg.getMethod(entryPoint)->front().front(), std::set<const llvm::Value*>({ zeroValue() })));
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
