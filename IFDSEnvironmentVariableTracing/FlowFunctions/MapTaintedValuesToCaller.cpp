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

  const auto srcMemLocationSeq = DataFlowUtils::getSubsetMemoryLocationSeq(returnValue, fact);

  bool isReturnValueTainted = !srcMemLocationSeq.empty();

  if (isReturnValueTainted) {
    ExtendedValue evRetInst(fact);
    evRetInst.setCallee(callInst);
    evRetInst.setRelocationSkipPartsCount(srcMemLocationSeq.size());

    targetFacts.insert(evRetInst);

    lineNumberStore.addLineNumber(callInst);
    lineNumberStore.addLineNumber(retInst);
  }

  return targetFacts;
}

} // namespace
