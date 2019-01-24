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

  bool genFact = DataFlowUtils::isSubsetMemoryLocationSeq(srcMemLocationSeq, factMemLocationSeq);
  if (genFact) {
    const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                          srcMemLocationSeq);

    ExtendedValue ev(fact);
    ev.setMemLocationSeq(relocatableMemLocationSeq);
    ev.setCallee(callInst);

    targetFacts.insert(ev);

    lineNumberStore.addLineNumber(callInst);
    lineNumberStore.addLineNumber(retInst);
  }

  return targetFacts;
}

} // namespace
