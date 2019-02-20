/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "IFDSEnvironmentVariableTracing.h"

#include "LineNumberStore.h"

#include "FlowFunctions/FlowFunctionWrapper.h"
#include "FlowFunctions/Identity.h"
#include "FlowFunctions/MapTaintedValuesToCallee.h"
#include "FlowFunctions/MapTaintedValuesToCaller.h"

#include "Utils/DataFlowUtils.h"

#include <cassert>
#include <fstream>
#include <set>
#include <vector>

#include <llvm/IR/Constants.h>
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

  /*
   * Store instruction
   */
  if (llvm::isa<llvm::StoreInst>(currentInst)) {

    ComputeTargetsExtFunction storeFlowFunction = [](const llvm::Instruction* currentInst,
                                                     ExtendedValue& fact,
                                                     LineNumberStore& lineNumberStore,
                                                     ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto storeInst = llvm::cast<llvm::StoreInst>(currentInst);

      const auto srcValue = storeInst->getValueOperand();
      const auto dstMemLocationMatr = storeInst->getPointerOperand();

      const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);
      const auto srcMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(srcValue);
      auto dstMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(dstMemLocationMatr);

      bool isArgumentPatch = DataFlowUtils::isPatchableArgumentStore(srcValue, fact);
      bool isReturnValuePatch = DataFlowUtils::isPatchableReturnValue(srcValue, fact);

      bool isSrcMemLocation = !srcMemLocationSeq.empty();

      std::set<ExtendedValue> targetFacts;

      /*
       * Patch argument
       */
      if (isArgumentPatch) {
        bool patchMemLocation = !dstMemLocationSeq.empty();
        if (patchMemLocation) {
          bool isArgCoerced = srcValue->getName().contains_lower("coerce");
          if (isArgCoerced) {
            assert(dstMemLocationSeq.size() > 1);
            dstMemLocationSeq.pop_back();
          }

          const auto patchedMemLocationSeq = DataFlowUtils::patchMemoryLocationFrame(factMemLocationSeq,
                                                                                     dstMemLocationSeq);

          ExtendedValue ev(fact);
          ev.setMemLocationSeq(patchedMemLocationSeq);
          ev.resetVarArgIndex();

          targetFacts.insert(ev);
          lineNumberStore.addLineNumber(storeInst);

          llvm::outs() << "[TRACK] Patched memory location (arg/store)" << "\n";
          llvm::outs() << "[TRACK] Source:" << "\n";
          DataFlowUtils::dumpFact(fact);
          llvm::outs() << "[TRACK] Destination:" << "\n";
          DataFlowUtils::dumpFact(ev);
        }
      }
      /*
       * Patch return value
       */
      else
      if (isReturnValuePatch) {
        bool patchMemLocation = !dstMemLocationSeq.empty();
        if (patchMemLocation) {
          bool isExtractValue = llvm::isa<llvm::ExtractValueInst>(srcValue);
          if (isExtractValue) {
            assert(dstMemLocationSeq.size() > 1);
            dstMemLocationSeq.pop_back();
          }

          const auto patchedMemLocationSeq = DataFlowUtils::patchMemoryLocationFrame(factMemLocationSeq,
                                                                                     dstMemLocationSeq);

          ExtendedValue ev(fact);
          ev.setMemLocationSeq(patchedMemLocationSeq);

          targetFacts.insert(ev);
          lineNumberStore.addLineNumber(storeInst);

          llvm::outs() << "[TRACK] Patched memory location (ret/store)" << "\n";
          llvm::outs() << "[TRACK] Source:" << "\n";
          DataFlowUtils::dumpFact(fact);
          llvm::outs() << "[TRACK] Destination:" << "\n";
          DataFlowUtils::dumpFact(ev);
        }
      }
      /*
       * If we got a memory location then we need to find all tainted memory locations for
       * it and create a new relocated address that relatively works from the memory location
       * destination. If the value is a pointer so is the desination as the store instruction
       * is defined as <store, ty val, *ty dst> that means we need to remove all facts that
       * started at the destination.
       */
      else
      if (isSrcMemLocation) {
        bool genFact = DataFlowUtils::isSubsetMemoryLocationSeq(srcMemLocationSeq, factMemLocationSeq);
        bool killFact = DataFlowUtils::isSubsetMemoryLocationSeq(dstMemLocationSeq, factMemLocationSeq) ||
                        DataFlowUtils::isKillAfterStoreFact(fact);

        if (genFact) {
          const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                                srcMemLocationSeq);
          const auto relocatedMemLocationSeq = DataFlowUtils::joinMemoryLocationSeqs(dstMemLocationSeq,
                                                                                     relocatableMemLocationSeq);

          ExtendedValue ev(fact);
          ev.setMemLocationSeq(relocatedMemLocationSeq);

          targetFacts.insert(ev);
          lineNumberStore.addLineNumber(storeInst);

          llvm::outs() << "[TRACK] Relocated memory location (store)" << "\n";
          llvm::outs() << "[TRACK] Source:" << "\n";
          DataFlowUtils::dumpFact(fact);
          llvm::outs() << "[TRACK] Destination:" << "\n";
          DataFlowUtils::dumpFact(ev);
        }
        if (!killFact) targetFacts.insert(fact);
      }
      else {
        bool genFact = DataFlowUtils::isValueTainted(srcValue, fact);
        bool killFact = DataFlowUtils::isSubsetMemoryLocationSeq(dstMemLocationSeq, factMemLocationSeq) ||
                        DataFlowUtils::isKillAfterStoreFact(fact);

        if (genFact) {
          ExtendedValue ev(storeInst);
          ev.setMemLocationSeq(dstMemLocationSeq);

          targetFacts.insert(ev);
          lineNumberStore.addLineNumber(storeInst);
        }
        if (!killFact) targetFacts.insert(fact);
      }

      return targetFacts;
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, storeFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Branch / Switch instruction
   */
  else
  if (llvm::isa<llvm::BranchInst>(currentInst) ||
      llvm::isa<llvm::SwitchInst>(currentInst)) {

    ComputeTargetsExtFunction blockFlowFunction = [](const llvm::Instruction* currentInst,
                                                     ExtendedValue& fact,
                                                     LineNumberStore& lineNumberStore,
                                                     ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const llvm::Value* condition = nullptr;

      if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(currentInst)) {
        bool isConditional = branchInst->isConditional();

        if (isConditional) condition = branchInst->getCondition();
      }
      else
      if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(currentInst)) {
        condition = switchInst->getCondition();
      }
      else {
        assert(false && "This MUST not happen");
      }

      if (condition) {
        bool isConditionTainted = DataFlowUtils::isValueTainted(condition, fact) ||
                                  DataFlowUtils::isMemoryLocationTainted(condition, fact);
        if (isConditionTainted) {
          const auto startBasicBlock = currentInst->getParent();
          const auto startBasicBlockLabel = startBasicBlock->getName();

          llvm::outs() << "[TRACK] Searching end of block label for: " << startBasicBlockLabel << "\n";

          const auto endBasicBlock = DataFlowUtils::getEndOfTaintedBlock(startBasicBlock);
          const auto endBasicBlockLabel = endBasicBlock ? endBasicBlock->getName() : "";

          llvm::outs() << "[TRACK] End of block label: " << endBasicBlockLabel << "\n";

          ExtendedValue ev(currentInst);
          ev.setEndOfTaintedBlockLabel(endBasicBlockLabel);

          lineNumberStore.addLineNumber(currentInst);

          return { fact, ev };
        }
      }

      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, blockFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * GetElementPtr instruction
   *
   * Track increments of vararg indexes + value taints
   */
  else
  if (llvm::isa<llvm::GetElementPtrInst>(currentInst)) {

    ComputeTargetsExtFunction gepInstFlowFunction = [](const llvm::Instruction* currentInst,
                                                       ExtendedValue& fact,
                                                       LineNumberStore& lineNumberStore,
                                                       ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto gepInst = llvm::cast<llvm::GetElementPtrInst>(currentInst);
      const auto gepInstPtr = gepInst->getPointerOperand();

      bool isVarArgFact = fact.isVarArg() && !fact.isVarArgTemplate();
      if (isVarArgFact) {
        bool killFact = gepInstPtr->getName().contains_lower("reg_save_area");
        if (killFact) return { };

        bool incrementCurrentVarArgIndex = gepInst->getName().contains_lower("overflow_arg_area.next");
        if (incrementCurrentVarArgIndex) {
          const auto gepVaListMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(gepInstPtr);

          bool isSameVaList = DataFlowUtils::isSubsetMemoryLocationSeq(fact.getVaListMemLocationSeq(),
                                                                       gepVaListMemLocationSeq);
          if (isSameVaList) {
            ExtendedValue ev(fact);
            ev.incrementCurrentVarArgIndex();

            return { ev };
          }
        }
      }
      else {
        bool isPtrTainted = DataFlowUtils::isValueTainted(gepInstPtr, fact);
        if (isPtrTainted) return { fact, ExtendedValue(gepInst) };
      }

      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, gepInstFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Phi node instruction
   *
   * Every Phi node that appears after a tainted branch is automatically added
   * through the flow function wrapper. We need to consider the case here that
   * the branch itself is not tainted but one of its values.
   */
  else
  if (llvm::isa<llvm::PHINode>(currentInst)) {

    ComputeTargetsExtFunction phiNodeFlowFunction = [](const llvm::Instruction* currentInst,
                                                       ExtendedValue& fact,
                                                       LineNumberStore& lineNumberStore,
                                                       ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto phiNodeInst = llvm::cast<llvm::PHINode>(currentInst);

      for (const auto block : phiNodeInst->blocks()) {
        const auto incomingValue = phiNodeInst->getIncomingValueForBlock(block);

        bool isIncomingValueTainted = DataFlowUtils::isValueTainted(incomingValue, fact) ||
                                      DataFlowUtils::isMemoryLocationTainted(incomingValue, fact);
        if (isIncomingValueTainted) {
          lineNumberStore.addLineNumber(phiNodeInst);

          return { fact, ExtendedValue(phiNodeInst) };
        }
      }

      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, phiNodeFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Operands checking instruction
   */
  else
  if (DataFlowUtils::isCheckOperandsInst(currentInst)) {

    ComputeTargetsExtFunction checkOperandsFlowFunction = [](const llvm::Instruction* currentInst,
                                                             ExtendedValue& fact,
                                                             LineNumberStore& lineNumberStore,
                                                             ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      for (const auto& use : currentInst->operands()) {
        const auto& operand = use.get();

        bool isOperandTainted = DataFlowUtils::isValueTainted(operand, fact) ||
                                DataFlowUtils::isMemoryLocationTainted(operand, fact);
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
   * Return instruction
   */
  else
  if (llvm::isa<llvm::ReturnInst>(successorInst)) {

    ComputeTargetsExtFunction retFlowFunction = [](const llvm::Instruction* currentInst,
                                                   ExtendedValue& fact,
                                                   LineNumberStore& lineNumberStore,
                                                   ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto retInst = llvm::cast<llvm::ReturnInst>(currentInst);
      const auto retVal = retInst->getReturnValue();

      if (retVal) {
        bool isRetValTainted = DataFlowUtils::isValueTainted(retVal, fact) ||
                               DataFlowUtils::isMemoryLocationTainted(retVal, fact);
        if (isRetValTainted) {
          lineNumberStore.addLineNumber(retInst);

          return { fact, ExtendedValue(retInst) };
        }
      }

      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(successorInst, retFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Default: Identity
   */
  return Identity::getInstance(currentInst, lineNumberStore, zeroValue());
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
  ComputeTargetsExtFunction getCallToRetFlowFunction = [](const llvm::Instruction* currentInst,
                                                          ExtendedValue& fact,
                                                          LineNumberStore& lineNumberStore,
                                                          ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

    /*
     * For functions that kill facts and are handled in getSummaryFlowFunction()
     * we kill all facts here and just use what they have returned. This is
     * important e.g. if memset removes a store fact then it is not readded here
     * e.g. through identity function.
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

  const auto destMthdName = destMthd->getName();

  /*
   * We exclude function ptr calls as they will be applied to every
   * function matching its signature (@see LLVMBasedICFG.cpp:217)
   */
  const auto callInst = llvm::cast<llvm::CallInst>(callStmt);
  bool isStaticCallSite = callInst->getCalledFunction();
  if (!isStaticCallSite) return Identity::getInstance(callStmt, lineNumberStore, zeroValue());

  /*
   * Exclude certain functions here.
   */
  bool isBlackListedCall = BLACKLISTED_CALLS.find(destMthdName) != BLACKLISTED_CALLS.end();
  if (isBlackListedCall) {
    llvm::outs() << "[TRACK]: Skipping blacklisted call: " << destMthdName << "\n";

    return Identity::getInstance(callStmt, lineNumberStore, zeroValue());
  }

  /*
   * Memcpy / Memmove instruction
   */
  if (llvm::isa<llvm::MemTransferInst>(callStmt)) {

    ComputeTargetsExtFunction memTransferFlowFunction = [](const llvm::Instruction* currentInst,
                                                           ExtendedValue& fact,
                                                           LineNumberStore& lineNumberStore,
                                                           ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto memTransferInst = llvm::cast<const llvm::MemTransferInst>(currentInst);

      const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);
      const auto srcMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(memTransferInst->getRawSource());
      const auto dstMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(memTransferInst->getRawDest());

      bool isArgumentPatch = DataFlowUtils::isPatchableArgumentMemcpy(memTransferInst->getRawSource(),
                                                                      srcMemLocationSeq,
                                                                      fact);

      std::set<ExtendedValue> targetFacts;

      /*
       * Patch argument
       */
      if (isArgumentPatch) {
        const auto patchedMemLocationSeq = DataFlowUtils::patchMemoryLocationFrame(factMemLocationSeq,
                                                                                   dstMemLocationSeq);

        ExtendedValue ev(fact);
        ev.setMemLocationSeq(patchedMemLocationSeq);
        ev.resetVarArgIndex();

        targetFacts.insert(ev);
        lineNumberStore.addLineNumber(memTransferInst);

        llvm::outs() << "[TRACK] Patched memory location (arg/memcpy)" << "\n";
        llvm::outs() << "[TRACK] Source:" << "\n";
        DataFlowUtils::dumpFact(fact);
        llvm::outs() << "[TRACK] Destination:" << "\n";
        DataFlowUtils::dumpFact(ev);
      }
      else {
        bool genFact = DataFlowUtils::isSubsetMemoryLocationSeq(srcMemLocationSeq, factMemLocationSeq);
        bool killFact = DataFlowUtils::isSubsetMemoryLocationSeq(dstMemLocationSeq, factMemLocationSeq);

        if (genFact) {
          const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                                srcMemLocationSeq);
          const auto relocatedMemLocationSeq = DataFlowUtils::joinMemoryLocationSeqs(dstMemLocationSeq,
                                                                                     relocatableMemLocationSeq);
          ExtendedValue ev(fact);
          ev.setMemLocationSeq(relocatedMemLocationSeq);

          targetFacts.insert(ev);
          lineNumberStore.addLineNumber(memTransferInst);

          llvm::outs() << "[TRACK] Relocated memory location (memcpy/memmove)" << "\n";
          llvm::outs() << "[TRACK] Source:" << "\n";
          DataFlowUtils::dumpFact(fact);
          llvm::outs() << "[TRACK] Destination:" << "\n";
          DataFlowUtils::dumpFact(ev);
        }
        if (!killFact) targetFacts.insert(fact);
      }

      return targetFacts;
    };

    return std::make_shared<FlowFunctionWrapper>(callStmt, memTransferFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Memset instruction
   */
  else
  if (llvm::isa<llvm::MemSetInst>(callStmt)) {

    ComputeTargetsExtFunction memSetFlowFunction = [](const llvm::Instruction* currentInst,
                                                      ExtendedValue& fact,
                                                      LineNumberStore& lineNumberStore,
                                                      ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto memSetInst = llvm::cast<const llvm::MemSetInst>(currentInst);

      const auto dstMemLocationMatr = memSetInst->getRawDest();

      const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);
      const auto dstMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(dstMemLocationMatr);

      bool killFact = DataFlowUtils::isSubsetMemoryLocationSeq(dstMemLocationSeq, factMemLocationSeq);
      if (killFact) {
        lineNumberStore.addLineNumber(memSetInst);

        return { };
      }

      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(callStmt, memSetFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * va_start instruction
   */
  else
  if (llvm::isa<llvm::VAStartInst>(callStmt)) {

    ComputeTargetsExtFunction vaStartFlowFunction = [](const llvm::Instruction* currentInst,
                                                       ExtendedValue& fact,
                                                       LineNumberStore& lineNumberStore,
                                                       ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      std::set<ExtendedValue> targetFacts;
      targetFacts.insert(fact);

      bool isVarArgTemplateFact = fact.isVarArgTemplate();
      if (!isVarArgTemplateFact) return targetFacts;

      const auto vaStartInst = llvm::cast<llvm::VAStartInst>(currentInst);
      const auto vaListMemLocationMatr = vaStartInst->getArgList();

      const auto vaListMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(vaListMemLocationMatr);

      bool isValidMemLocationSeq = !vaListMemLocationSeq.empty();
      if (isValidMemLocationSeq) {
        ExtendedValue ev(fact);
        ev.setVaListMemLocationSeq(vaListMemLocationSeq);

        targetFacts.insert(ev);
        //lineNumberStore.addLineNumber(vaStartInst);

        llvm::outs() << "[TRACK] Created new VarArg from template" << "\n";
        llvm::outs() << "[TRACK] Template:" << "\n";
        DataFlowUtils::dumpFact(fact);
        llvm::outs() << "[TRACK] VarArg:" << "\n";
        DataFlowUtils::dumpFact(ev);
      }

      return targetFacts;
    };

    return std::make_shared<FlowFunctionWrapper>(callStmt, vaStartFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * va_end instruction
   */
  else
  if (llvm::isa<llvm::VAEndInst>(callStmt)) {

    ComputeTargetsExtFunction vaEndFlowFunction = [](const llvm::Instruction* currentInst,
                                                     ExtendedValue& fact,
                                                     LineNumberStore& lineNumberStore,
                                                     ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      bool isVarArgFact = fact.isVarArg() && !fact.isVarArgTemplate();
      if (!isVarArgFact) return { fact };

      const auto vaEndInst = llvm::cast<llvm::VAEndInst>(currentInst);
      const auto vaEndMemLocationMatr = vaEndInst->getArgList();

      const auto vaEndMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(vaEndMemLocationMatr);

      bool isValidMemLocationSeq = !vaEndMemLocationSeq.empty();
      if (isValidMemLocationSeq) {
        bool isVaListEqual = DataFlowUtils::isMemoryLocationSeqsEqual(vaEndMemLocationSeq,
                                                                      fact.getVaListMemLocationSeq());
        if (isVaListEqual) {
          llvm::outs() << "[TRACK] Killed VarArg" << "\n";
          DataFlowUtils::dumpFact(fact);

          return { };
        }
      }

      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(callStmt, vaEndFlowFunction, lineNumberStore, zeroValue());
  }

  /*
   * Provide summary for tainted call
   */
  bool isTaintedCall = TAINTED_CALLS.find(destMthdName) != TAINTED_CALLS.end();
  if (isTaintedCall) {
    ComputeTargetsExtFunction taintedCallFlowFunction = [](const llvm::Instruction* currentInst,
                                                           ExtendedValue& fact,
                                                           LineNumberStore& lineNumberStore,
                                                           ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      lineNumberStore.addLineNumber(currentInst);

      if (fact == zeroValue) return { ExtendedValue(currentInst) };
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(callStmt, taintedCallFlowFunction, lineNumberStore, zeroValue());
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
