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

  bool isReturnValueTainted = DataFlowUtils::isValueTainted(fact, returnValue) ||
                              DataFlowUtils::isMemoryLocationFrameEqual(fact, returnValue);

  if (isReturnValueTainted) {
    ExtendedValue evRetInst(fact);
    evRetInst.setCallee(callInst);
    targetFacts.insert(evRetInst);

    lineNumberStore.addLineNumber(callInst);
    lineNumberStore.addLineNumber(retInst);
  }

  return targetFacts;
}

} // namespace
