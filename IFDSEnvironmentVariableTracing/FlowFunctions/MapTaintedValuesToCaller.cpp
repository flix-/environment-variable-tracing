#include "MapTaintedValuesToCaller.h"

#include "../Utils/DataFlowUtils.h"

#include <llvm/Support/raw_ostream.h>

#include <phasar/Utils/LLVMShorthands.h>

namespace psr {

std::set<ExtendedValue>
MapTaintedValuesToCaller::computeTargets(ExtendedValue fact) {

  const auto returnValue = retInst->getReturnValue();
  if (!returnValue) return { };

  bool isReturnValueTainted = DataFlowUtils::isValueTainted(fact, returnValue);
  if (isReturnValueTainted) return { ExtendedValue(callInst) };

  return { };
}

} // namespace
