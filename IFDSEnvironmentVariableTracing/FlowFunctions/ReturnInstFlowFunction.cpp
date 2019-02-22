/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "ReturnInstFlowFunction.h"

namespace psr {

std::set<ExtendedValue>
ReturnInstFlowFunction::computeTargetsExt(ExtendedValue& fact) {

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
}

} // namespace
