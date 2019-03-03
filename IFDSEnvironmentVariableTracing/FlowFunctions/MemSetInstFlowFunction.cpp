/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#include "MemSetInstFlowFunction.h"

#include <llvm/IR/IntrinsicInst.h>

namespace psr {

std::set<ExtendedValue>
MemSetInstFlowFunction::computeTargetsExt(ExtendedValue& fact) {

  const auto memSetInst = llvm::cast<const llvm::MemSetInst>(currentInst);
  const auto dstMemLocationMatr = memSetInst->getRawDest();

  const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);
  auto dstMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(dstMemLocationMatr);

  bool isDstArrayDecay = DataFlowUtils::isArrayDecay(dstMemLocationMatr);
  if (isDstArrayDecay) dstMemLocationSeq.pop_back();

  bool killFact = DataFlowUtils::isSubsetMemoryLocationSeq(dstMemLocationSeq, factMemLocationSeq);
  if (killFact) {
    traceStats.add(memSetInst);

    return { };
  }

  return { fact };
}

} // namespace
