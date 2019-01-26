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

      ExtendedValue ev(fact);
      ev.setMemLocationSeq(patchableMemLocationSeq);

      targetFacts.insert(ev);

      llvm::outs() << "[TRACK] Relocated memory location (caller <- callee)" << "\n";
      llvm::outs() << "[TRACK] Source:" << "\n";
      DataFlowUtils::dumpMemoryLocation(fact);
      llvm::outs() << "[TRACK] Destination:" << "\n";
      DataFlowUtils::dumpMemoryLocation(ev);
    }
  }
  else {
    bool isRetValTainted = DataFlowUtils::isValueTainted(fact, retVal);
    if (isRetValTainted) {
      ExtendedValue ev(callInst);

      targetFacts.insert(ev);
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
