/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#include "PHINodeFlowFunction.h"

namespace psr {

std::set<ExtendedValue>
PHINodeFlowFunction::computeTargetsExt(ExtendedValue& fact)
{
  const auto phiNodeInst = llvm::cast<llvm::PHINode>(currentInst);

  for (const auto block : phiNodeInst->blocks()) {
    const auto incomingValue = phiNodeInst->getIncomingValueForBlock(block);

    bool isIncomingValueTainted = DataFlowUtils::isValueTainted(incomingValue, fact) ||
                                  DataFlowUtils::isMemoryLocationTainted(incomingValue, fact);

    if (isIncomingValueTainted) {
      traceStats.add(phiNodeInst);

      return { fact, ExtendedValue(phiNodeInst) };
    }
  }

  return { fact };
}

} // namespace
