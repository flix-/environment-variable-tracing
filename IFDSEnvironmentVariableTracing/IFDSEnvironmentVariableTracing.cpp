#include "IFDSEnvironmentVariableTracing.h"

#include "LineNumberStore.h"

#include "FlowFunctions/FlowFunctionWrapper.h"
#include "FlowFunctions/Identity.h"
#include "FlowFunctions/MapTaintedValuesToCallee.h"
#include "FlowFunctions/MapTaintedValuesToCaller.h"

#include "Utils/DataFlowUtils.h"

#include <fstream>

#include <llvm/IR/Constants.h>
#include <llvm/IR/IntrinsicInst.h>

#include <llvm/Support/raw_ostream.h>

#include <phasar/PhasarLLVM/ControlFlow/LLVMBasedICFG.h>


namespace psr {

static const char* LINE_NUMBERS_OUTPUT_FILE = "line-numbers.txt";
static const char* GETENV_CALL = "getenv";


std::unique_ptr<IFDSTabulationProblemPluginExtendedValue>
makeIFDSEnvironmentVariableTracing(LLVMBasedICFG& icfg,
                                   std::vector<std::string> entryPoints) {

  return std::unique_ptr<IFDSTabulationProblemPluginExtendedValue>(new IFDSEnvironmentVariableTracing(icfg, entryPoints));
}

__attribute__((constructor)) void init() {

  llvm::outs() << "init - makeIFDSEnvironmentVariableTracing" << "\n";
  IFDSTabulationProblemPluginExtendedValueFactory["IFDSEnvironmentVariableTracing"] = &makeIFDSEnvironmentVariableTracing;
}

__attribute__((destructor)) void fini() {

  llvm::outs() << "fini - makeIFDSEnvironmentVariableTracing" << "\n";
}

IFDSEnvironmentVariableTracing::IFDSEnvironmentVariableTracing(LLVMBasedICFG& icfg,
                                                               std::vector<std::string> entryPoints)
    : IFDSTabulationProblemPluginExtendedValue(icfg, entryPoints) { }

std::shared_ptr<FlowFunction<ExtendedValue>>
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
                                                    ExtendedValue& fact,
                                                    LineNumberStore& lineNumberStore,
                                                    ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto loadInst = llvm::cast<llvm::LoadInst>(currentInst);

      const auto memLocation = loadInst->getPointerOperand();

      bool isLoadTainted = DataFlowUtils::isValueEqual(fact, memLocation) ||
                           DataFlowUtils::isMemoryLocationEqual(fact, memLocation);

      if (isLoadTainted) {
        lineNumberStore.addLineNumber(loadInst);
        return { fact, ExtendedValue(loadInst) };
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, loadFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Store instruction
   */
  else if (llvm::isa<llvm::StoreInst>(currentInst)) {
    llvm::outs() << "Got store instruction" << "\n";

    ComputeTargetsExtFunction storeFlowFunction = [](const llvm::Instruction* currentInst,
                                                     ExtendedValue& fact,
                                                     LineNumberStore& lineNumberStore,
                                                     ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto storeInst = llvm::cast<llvm::StoreInst>(currentInst);

      const auto value = storeInst->getValueOperand();
      const auto memLocation = storeInst->getPointerOperand();

      /*
       * Patch memory location frame if value is an argument
       */
      bool isValueArgument = llvm::isa<llvm::Argument>(value);
      if (isValueArgument) {
        bool patchMemLocationFrame = fact.getPatchedMemLocationFrame() == value;
        if (patchMemLocationFrame) {
          const auto patchedMemLocationFrame = DataFlowUtils::getMemoryLocationFrame(memLocation);
          fact.setPatchedMemLocationFrame(patchedMemLocationFrame);
          llvm::outs() << "Patched" << "\n"; fact.getValue()->print(llvm::outs()); llvm::outs() << "\n" << "to" << "\n"; fact.getPatchedMemLocationFrame()->print(llvm::outs()); llvm::outs() << "\n";
        }
        return { fact };
      }

      /*
       * If we haven't got an argument as value proceed with usual store instruction
       * processing...
       *
       * Rules
       * -----
       *
       * (1) If a value is tainted GEN store instruction fact
       * (2) If destination is tainted KILL old memory location fact
       * (3) If a value is a temporary (call, load, ...) KILL temporary fact
       * (4) Keep all other facts
       */

      bool isMemLocationTainted = DataFlowUtils::isMemoryLocationEqual(fact, memLocation);
      bool isValueTaintedByTemporary = DataFlowUtils::isValueEqual(fact, value);
      bool isValueTaintedByMemLocation = DataFlowUtils::isMemoryLocationEqual(fact, value);

      bool genStoreInst = isValueTaintedByTemporary || isValueTaintedByMemLocation;
      bool idFact = !isMemLocationTainted && !isValueTaintedByTemporary;

      std::set<ExtendedValue> targetFacts;

      if (genStoreInst) {
        targetFacts.insert(ExtendedValue(storeInst));
        lineNumberStore.addLineNumber(storeInst);
      }
      if (idFact) targetFacts.insert(fact);

      return targetFacts;
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, storeFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Phi node instruction
   */
  else if (llvm::isa<llvm::PHINode>(currentInst)) {
    llvm::outs() << "Got phi node instruction" << "\n";

    ComputeTargetsExtFunction phiNodeFlowFunction = [](const llvm::Instruction* currentInst,
                                                       ExtendedValue& fact,
                                                       LineNumberStore& lineNumberStore,
                                                       ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

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
                               DataFlowUtils::isMemoryLocationEqual(fact, use.get());
              if (isTainted) {
                lineNumberStore.addLineNumber(phiNodeInst);
                return { fact, ExtendedValue(phiNodeInst) };
              }
            }
          }
        }
        /*
         * If it's not a constant check whether value is tainted...
         */
        else {
          bool isTainted = DataFlowUtils::isValueEqual(fact, incomingValue) ||
                           DataFlowUtils::isMemoryLocationEqual(fact, incomingValue);
          if (isTainted) {
            lineNumberStore.addLineNumber(phiNodeInst);
            return { fact, ExtendedValue(phiNodeInst) };
          }
        }
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, phiNodeFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Branch instruction
   */
  else if (llvm::isa<llvm::BranchInst>(currentInst)) {
    llvm::outs() << "Got branch instruction" << "\n";

    ComputeTargetsExtFunction branchFlowFunction = [](const llvm::Instruction* currentInst,
                                                      ExtendedValue& fact,
                                                      LineNumberStore& lineNumberStore,
                                                      ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto branchInst = llvm::cast<llvm::BranchInst>(currentInst);

      bool isConditional = branchInst->isConditional();
      if (isConditional) {
        const auto condition = branchInst->getCondition();

        bool isBranchTainted = DataFlowUtils::isValueEqual(fact, condition);
        if (isBranchTainted) {
          lineNumberStore.addLineNumber(branchInst);
          return { fact, ExtendedValue(branchInst) };
        }
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, branchFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Switch instruction
   */
  else if (llvm::isa<llvm::SwitchInst>(currentInst)) {
    llvm::outs() << "Got switch instruction" << "\n";

    ComputeTargetsExtFunction switchFlowFunction = [](const llvm::Instruction* currentInst,
                                                      ExtendedValue& fact,
                                                      LineNumberStore& lineNumberStore,
                                                      ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto switchInst = llvm::cast<llvm::SwitchInst>(currentInst);

      const auto condition = switchInst->getCondition();
      /*
       * No need to check memory locations here as it is forbidden to use
       * a memory address as a condition in switch statement.
       */
      bool isSwitchTainted = DataFlowUtils::isValueEqual(fact, condition);
      if (isSwitchTainted) {
        lineNumberStore.addLineNumber(switchInst);
        return { fact, ExtendedValue(switchInst) };
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, switchFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Operands checking instruction
   */
  else if (isCheckOperandsInst) {
    llvm::outs() << "Got operands checking instruction (" << currentInst->getOpcodeName() << ")" << "\n";

    ComputeTargetsExtFunction checkOperandsFlowFunction = [](const llvm::Instruction* currentInst,
                                                             ExtendedValue& fact,
                                                             LineNumberStore& lineNumberStore,
                                                             ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      for (const auto &use : currentInst->operands()) {
        bool isOperandTainted = DataFlowUtils::isValueEqual(fact, use.get()) ||
                                DataFlowUtils::isMemoryLocationEqual(fact, use.get());
        if (isOperandTainted) {
          lineNumberStore.addLineNumber(currentInst);
          return { fact, ExtendedValue(currentInst) };
        }
      }
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, checkOperandsFlowFunction, lineNumberStore, zeroValue());
  }

  /*
   * Default: Identity
   */
  return Identity::getInstance(currentInst, lineNumberStore, zeroValue());
}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSEnvironmentVariableTracing::getCallFlowFunction(const llvm::Instruction* callStmt,
                                                    const llvm::Function* destMthd) {

  llvm::outs() << "getCallFlowFunction()" << "\n";
  callStmt->print(llvm::outs()); llvm::outs() << "\n\n";

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

  llvm::outs() << "getRetFlowFunction()" << "\n";

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
                                                          ExtendedValue& fact,
                                                          LineNumberStore& lineNumberStore,
                                                          ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

    /*
     * For functions that kill facts and are handled in getSummaryFlowFunction()
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

  return std::make_shared<FlowFunctionWrapper>(callSite, getCallToRetFlowFunction, lineNumberStore, zeroValue());
}

/*
 * If we return sth. different than a nullptr the callee will not be traversed. Instead
 * facts according to the defined flow function will be taken into account.
 */
std::shared_ptr<FlowFunction<ExtendedValue>>
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
                                                           ExtendedValue& fact,
                                                           LineNumberStore& lineNumberStore,
                                                           ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto memTransferInst = llvm::cast<const llvm::MemTransferInst>(currentInst);

      const auto srcMemLocation = memTransferInst->getRawSource();
      const auto dstMemLocation = memTransferInst->getRawDest();

      const auto patchedStartMemLocation = DataFlowUtils::isMemoryLocationSubsetEqual(srcMemLocation, fact);
      bool isDstMemLocationFrameTainted = DataFlowUtils::isMemoryLocationFrameEqual(fact, dstMemLocation);

      bool genStoreInst = patchedStartMemLocation != nullptr;
      bool idFact = !isDstMemLocationFrameTainted;

      std::set<ExtendedValue> targetFacts;

      if (genStoreInst) {
        const auto patchedMemoryLocationFrame = DataFlowUtils::getMemoryLocationFrame(dstMemLocation);

        ExtendedValue patchedMemoryLocation = fact;
        patchedMemoryLocation.setPatchedMemLocationFrame(patchedMemoryLocationFrame);
        patchedMemoryLocation.setPatchedStartMemLocation(patchedStartMemLocation);
        targetFacts.insert(patchedMemoryLocation);

        lineNumberStore.addLineNumber(memTransferInst);

        llvm::outs() << "Patched memory location frame from" << "\n"; patchedMemoryLocation.getValue()->print(llvm::outs()); llvm::outs() << "\n" << "to" << "\n"; patchedMemoryLocation.getPatchedMemLocationFrame()->print(llvm::outs()); llvm::outs() << "\n";
        llvm::outs() << "Patched start memory location to" << "\n"; patchedMemoryLocation.getPatchedStartMemLocation()->print(llvm::outs()); llvm::outs() << "\n";
      }
      if (idFact) targetFacts.insert(fact);

      return targetFacts;
    };

    return std::make_shared<FlowFunctionWrapper>(callStmt, memTransferFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Memset instruction
   */
  else if (llvm::isa<llvm::MemSetInst>(callStmt)) {
    llvm::outs() << "Got memset instruction" << "\n";

    ComputeTargetsExtFunction memSetFlowFunction = [](const llvm::Instruction* currentInst,
                                                      ExtendedValue& fact,
                                                      LineNumberStore& lineNumberStore,
                                                      ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto memSetInst = llvm::cast<const llvm::MemSetInst>(currentInst);

      const auto dstMemLocation = memSetInst->getRawDest();

      bool isDstMemLocationTainted = DataFlowUtils::isMemoryLocationFrameEqual(fact, dstMemLocation);
      if (isDstMemLocationTainted) return { };

      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(callStmt, memSetFlowFunction, lineNumberStore, zeroValue());
  }

  /*
   * Provide summary for getenv() call
   */
  bool isGetenvCall = destMthd->getName().compare_lower(GETENV_CALL) == 0;
  if (isGetenvCall) {
    ComputeTargetsExtFunction getenvCallFlowFunction = [](const llvm::Instruction* currentInst,
                                                          ExtendedValue& fact,
                                                          LineNumberStore& lineNumberStore,
                                                          ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      lineNumberStore.addLineNumber(currentInst);
      if (fact == zeroValue) return { ExtendedValue(currentInst) };
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(callStmt, getenvCallFlowFunction, lineNumberStore, zeroValue());
  }

  /*
   * Skip all declarations
   */
  bool isDeclaration = destMthd->isDeclaration();
  if (isDeclaration) return Identity::getInstance(callStmt, lineNumberStore, zeroValue());

  /*
   * Follow call -> getCallFlowFunction()
   */
  return nullptr;
}

std::map<const llvm::Instruction*, std::set<ExtendedValue>>
IFDSEnvironmentVariableTracing::initialSeeds() {

  llvm::outs() << "initialSeeds()" << "\n";

  std::map<const llvm::Instruction*, std::set<ExtendedValue>> seedMap;
  for (auto &entryPoint : this->EntryPoints) {
    seedMap.insert(std::make_pair(&icfg.getMethod(entryPoint)->front().front(), std::set<ExtendedValue>({ zeroValue() })));
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
