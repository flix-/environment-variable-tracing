/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "MemSetInstFlowFunction.h"

#include <llvm/IR/IntrinsicInst.h>

namespace psr {

std::set<ExtendedValue>
MemSetInstFlowFunction::computeTargetsExt(ExtendedValue& fact) {

  const auto memSetInst = llvm::cast<const llvm::MemSetInst>(currentInst);
  const auto dstMemLocationMatr = memSetInst->getRawDest();

  const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);
  const auto dstMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(dstMemLocationMatr);

  bool killFact = DataFlowUtils::isSubsetMemoryLocationSeq(dstMemLocationSeq, factMemLocationSeq);
  if (killFact) {
    lineNumberStore.addLineNumber(memSetInst);

    return { };
  }

  return { fact };
}

} // namespace
