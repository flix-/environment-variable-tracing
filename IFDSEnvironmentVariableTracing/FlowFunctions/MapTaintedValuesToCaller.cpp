/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "MapTaintedValuesToCaller.h"

#include "../Utils/DataFlowUtils.h"

#include <llvm/Support/raw_ostream.h>

#include <phasar/Utils/LLVMShorthands.h>

namespace psr {

std::set<ExtendedValue>
MapTaintedValuesToCaller::computeTargets(ExtendedValue fact) {

  std::set<ExtendedValue> targetFacts;

  const auto retVal = retInst->getReturnValue();
  if (!retVal) return targetFacts;

  const auto retValMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(retVal);

  bool isRetValMemLocation = !retValMemLocationSeq.empty();
  if (isRetValMemLocation) {
    const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);

    bool genFact = DataFlowUtils::isSubsetMemoryLocationSeq(retValMemLocationSeq,
                                                            factMemLocationSeq);
    if (genFact) {
      const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                            retValMemLocationSeq);
      std::vector<const llvm::Value*> patchablePart{callInst};
      const auto patchableMemLocationSeq = DataFlowUtils::joinMemoryLocationSeqs(patchablePart,
                                                                                 relocatableMemLocationSeq);

      /*
       * We need to set this to call inst because we can have the case where we
       * only return the call inst in the mem location sequence (which is not a
       * a memory address). We then land in the else branch below and need to find
       * the call instance (see test case 230-function-ptr-2).
       */
      ExtendedValue ev(callInst);
      ev.setMemLocationSeq(patchableMemLocationSeq);

      targetFacts.insert(ev);

      llvm::outs() << "[TRACK] Added patchable memory location (caller <- callee)" << "\n";
      llvm::outs() << "[TRACK] Source:" << "\n";
      DataFlowUtils::dumpMemoryLocation(fact);
      llvm::outs() << "[TRACK] Destination:" << "\n";
      DataFlowUtils::dumpMemoryLocation(ev);
    }
  }
  else {
    bool isRetValTainted = DataFlowUtils::isValueTainted(retVal, fact);
    if (isRetValTainted) {
      std::vector<const llvm::Value*> patchablePart{callInst};

      ExtendedValue ev(callInst);
      ev.setMemLocationSeq(patchablePart);

      targetFacts.insert(ev);

      llvm::outs() << "[TRACK] Added patchable memory location (caller <- callee)" << "\n";
      llvm::outs() << "[TRACK] Source:" << "\n";
      DataFlowUtils::dumpMemoryLocation(fact);
      llvm::outs() << "[TRACK] Destination:" << "\n";
      DataFlowUtils::dumpMemoryLocation(ev);
    }
  }

  bool addLineNumbers = !targetFacts.empty();
  if (addLineNumbers) {
    lineNumberStore.addLineNumber(callInst);
    lineNumberStore.addLineNumber(retInst);
  }

  return targetFacts;
}

} // namespace
