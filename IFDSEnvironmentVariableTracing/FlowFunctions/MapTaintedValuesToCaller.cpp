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

  const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);
  const auto srcMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(returnValue);

  bool genMemLocationFact = DataFlowUtils::isSubsetMemoryLocationSeq(srcMemLocationSeq, factMemLocationSeq);
  if (genMemLocationFact) {
    const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                          srcMemLocationSeq);

    ExtendedValue ev(fact);
    ev.setMemLocationSeq(relocatableMemLocationSeq);
    ev.setCallee(callInst);

    targetFacts.insert(ev);
  } else {
    bool genCallFact = DataFlowUtils::isValueTainted(fact, returnValue);
    if (genCallFact) {
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
