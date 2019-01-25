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

  const auto returnValue = retInst->getReturnValue();
  if (!returnValue) return targetFacts;

  bool isReturnValueTrivial = DataFlowUtils::isPrimitiveType(returnValue->getType());

  if (isReturnValueTrivial) {
    bool isReturnValueTainted = DataFlowUtils::isValueTainted(fact, returnValue);
    if (isReturnValueTainted) {
      ExtendedValue ev(callInst);

      targetFacts.insert(ev);
    }
  }
  else {
    const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);
    const auto returnValueMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(returnValue);

    bool genFact = DataFlowUtils::isSubsetMemoryLocationSeq(returnValueMemLocationSeq,
                                                            factMemLocationSeq);
    if (genFact) {
      const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                            returnValueMemLocationSeq);
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

  bool addLineNumbers = !targetFacts.empty();
  if (addLineNumbers) {
    lineNumberStore.addLineNumber(callInst);
    lineNumberStore.addLineNumber(retInst);
  }

  return targetFacts;
}

} // namespace
