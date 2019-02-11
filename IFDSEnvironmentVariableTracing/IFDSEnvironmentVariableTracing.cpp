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

#include <fstream>
#include <vector>
#include <set>

#include <llvm/IR/Constants.h>
#include <llvm/IR/IntrinsicInst.h>

#include <llvm/Support/raw_ostream.h>

#include <phasar/PhasarLLVM/ControlFlow/LLVMBasedICFG.h>


namespace psr {

static const std::set<std::string> TAINTED_CALLS = { "getenv",
                                                     "secure_getenv"
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
    : IFDSTabulationProblemPluginExtendedValue(icfg, entryPoints) {}

std::shared_ptr<FlowFunction<ExtendedValue>>
IFDSEnvironmentVariableTracing::getNormalFlowFunction(const llvm::Instruction* currentInst,
                                                      const llvm::Instruction* successorInst) {

  bool isCheckOperandsInst = llvm::isa<llvm::UnaryInstruction>(currentInst) ||
                             llvm::isa<llvm::BinaryOperator>(currentInst) ||
                             llvm::isa<llvm::CmpInst>(currentInst) ||
                             llvm::isa<llvm::SelectInst>(currentInst);
  /*
   * Load instruction
   */
  if (llvm::isa<llvm::LoadInst>(currentInst)) {

    ComputeTargetsExtFunction loadFlowFunction = [](const llvm::Instruction* currentInst,
                                                    ExtendedValue& fact,
                                                    LineNumberStore& lineNumberStore,
                                                    ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto loadInst = llvm::cast<llvm::LoadInst>(currentInst);

      const auto memLocation = loadInst->getPointerOperand();

      bool isLoadTainted = DataFlowUtils::isValueTainted(fact, memLocation) ||
                           DataFlowUtils::isMemoryLocationTainted(fact, memLocation);

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
  else
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
          DataFlowUtils::dumpMemoryLocation(fact);
          llvm::outs() << "[TRACK] Destination:" << "\n";
          DataFlowUtils::dumpMemoryLocation(ev);
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
          DataFlowUtils::dumpMemoryLocation(fact);
          llvm::outs() << "[TRACK] Destination:" << "\n";
          DataFlowUtils::dumpMemoryLocation(ev);
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
          DataFlowUtils::dumpMemoryLocation(fact);
          llvm::outs() << "[TRACK] Destination:" << "\n";
          DataFlowUtils::dumpMemoryLocation(ev);
        }
        if (!killFact) targetFacts.insert(fact);
      }
      else {
        bool genFact = DataFlowUtils::isValueTainted(fact, srcValue);
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
   * GetElementPtr instruction
   *
   * Sole purpose is to track increments of var arg indexes.
   */
  else
  if (llvm::isa<llvm::GetElementPtrInst>(currentInst)) {

    ComputeTargetsExtFunction gepInstFlowFunction = [](const llvm::Instruction* currentInst,
                                                       ExtendedValue& fact,
                                                       LineNumberStore& lineNumberStore,
                                                       ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto gepInst = llvm::cast<llvm::GetElementPtrInst>(currentInst);

      bool isVarArgFact = fact.isVarArg();
      if (!isVarArgFact) return { fact };

      bool genFact = gepInst->getName().contains_lower("overflow_arg_area.next");
      bool killFact = gepInst->getPointerOperand()->getName().contains_lower("reg_save_area");

      if (genFact) {
        ExtendedValue ev(fact);
        ev.incrementCurrentVarArgIndex();

        return { ev };
      }
      else
      if (killFact) {
        return { };
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

        bool isTainted = DataFlowUtils::isValueTainted(fact, incomingValue) ||
                         DataFlowUtils::isMemoryLocationTainted(fact, incomingValue);
        if (isTainted) {
          lineNumberStore.addLineNumber(phiNodeInst);
          return { fact, ExtendedValue(phiNodeInst) };
        }
      }

      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, phiNodeFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Branch instruction
   */
  else
  if (llvm::isa<llvm::BranchInst>(currentInst)) {

    ComputeTargetsExtFunction branchFlowFunction = [](const llvm::Instruction* currentInst,
                                                      ExtendedValue& fact,
                                                      LineNumberStore& lineNumberStore,
                                                      ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      const auto branchInst = llvm::cast<llvm::BranchInst>(currentInst);

      bool isConditional = branchInst->isConditional();
      if (isConditional) {
        const auto condition = branchInst->getCondition();

        bool isBranchTainted = DataFlowUtils::isValueTainted(fact, condition);
        if (isBranchTainted) {
          const auto endOfTaintedBranchBB = DataFlowUtils::getEndOfBlockBB(branchInst);
          const auto endOfTaintedBranchSuccLabels = DataFlowUtils::getSuccessorLabels(endOfTaintedBranchBB);

          for (const auto& succ : endOfTaintedBranchSuccLabels) {
            llvm::outs() << "[TRACK] Succ: " << succ << "\n";
          }

          const auto endOfTaintedBranchLabel = endOfTaintedBranchBB ? endOfTaintedBranchBB->getName() : "";
          if (endOfTaintedBranchLabel.empty()) llvm::outs() << "[TRACK] No end of tainted branch label found! Unreachable or algorithm incomplete?" << "\n";

          ExtendedValue ev(branchInst);
          ev.setEndOfTaintedBlockLabels(endOfTaintedBranchLabel,
                                        endOfTaintedBranchSuccLabels);

          lineNumberStore.addLineNumber(branchInst);

          return { ev };
        }
      }

      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, branchFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Switch instruction
   */
  else
  if (llvm::isa<llvm::SwitchInst>(currentInst)) {

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
      bool isSwitchTainted = DataFlowUtils::isValueTainted(fact, condition);
      if (isSwitchTainted) {
        const auto endOfTaintedSwitchBB = DataFlowUtils::getEndOfBlockBB(switchInst);
        const auto endOfTaintedSwitchSuccLabels = DataFlowUtils::getSuccessorLabels(endOfTaintedSwitchBB);

        const auto endOfTaintedSwitchLabel = endOfTaintedSwitchBB ? endOfTaintedSwitchBB->getName() : "";
        if (endOfTaintedSwitchLabel.empty()) llvm::outs() << "[TRACK] No end of tainted switch label found! Unreachable or algorithm incomplete?" << "\n";

        ExtendedValue ev(switchInst);
        ev.setEndOfTaintedBlockLabels(endOfTaintedSwitchLabel,
                                      endOfTaintedSwitchSuccLabels);

        lineNumberStore.addLineNumber(switchInst);

        return { ev };
      }

      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, switchFlowFunction, lineNumberStore, zeroValue());
  }
  /*
   * Operands checking instruction
   */
  else
  if (isCheckOperandsInst) {

    ComputeTargetsExtFunction checkOperandsFlowFunction = [](const llvm::Instruction* currentInst,
                                                             ExtendedValue& fact,
                                                             LineNumberStore& lineNumberStore,
                                                             ExtendedValue& zeroValue) -> std::set<ExtendedValue> {

      for (const auto &use : currentInst->operands()) {
        bool isOperandTainted = DataFlowUtils::isValueTainted(fact, use.get()) ||
                                DataFlowUtils::isMemoryLocationTainted(fact, use.get());
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

  /*
   * We exclude function ptr calls as they will be applied to every
   * function matching its signature (@see LLVMBasedICFG.cpp:217)
   */
  const auto callInst = llvm::cast<llvm::CallInst>(callStmt);
  bool isStaticCallSite = callInst->getCalledFunction();
  if (!isStaticCallSite) return Identity::getInstance(callStmt, lineNumberStore, zeroValue());

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
        DataFlowUtils::dumpMemoryLocation(fact);
        llvm::outs() << "[TRACK] Destination:" << "\n";
        DataFlowUtils::dumpMemoryLocation(ev);
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
          DataFlowUtils::dumpMemoryLocation(fact);
          llvm::outs() << "[TRACK] Destination:" << "\n";
          DataFlowUtils::dumpMemoryLocation(ev);
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
   * Provide summary for tainted call
   */
  bool isTaintedCall = TAINTED_CALLS.find(destMthd->getName().lower()) != TAINTED_CALLS.end();
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
                                  std::set<ExtendedValue>({zeroValue()})));
  }

  return seedMap;
}

void
IFDSEnvironmentVariableTracing::printReport() {

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
