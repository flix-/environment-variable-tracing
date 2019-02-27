/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "MemTransferInstFlowFunction.h"

#include <llvm/IR/IntrinsicInst.h>

namespace psr {

std::set<ExtendedValue>
MemTransferInstFlowFunction::computeTargetsExt(ExtendedValue& fact) {

  const auto memTransferInst = llvm::cast<const llvm::MemTransferInst>(currentInst);

  const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);
  const auto srcMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(memTransferInst->getRawSource());
  const auto dstMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(memTransferInst->getRawDest());

  bool isArgumentPatch = DataFlowUtils::isPatchableArgumentMemcpy(memTransferInst->getRawSource(),
                                                                  srcMemLocationSeq,
                                                                  fact);
  std::set<ExtendedValue> targetFacts;

  /*
   * Patch argument
   */
  if (isArgumentPatch) {
    const auto patchedMemLocationSeq = DataFlowUtils::patchMemoryLocationFrame(factMemLocationSeq,
                                                                               dstMemLocationSeq);
    ExtendedValue ev(fact);
    ev.setMemLocationSeq(patchedMemLocationSeq);
    ev.resetVarArgIndex();

    targetFacts.insert(ev);
    traceStats.add(memTransferInst);

    llvm::outs() << "[TRACK] Patched memory location (arg/memcpy)" << "\n";
    llvm::outs() << "[TRACK] Source:" << "\n";
    DataFlowUtils::dumpFact(fact);
    llvm::outs() << "[TRACK] Destination:" << "\n";
    DataFlowUtils::dumpFact(ev);
  }
  else {
    bool genFact = DataFlowUtils::isSubsetMemoryLocationSeq(srcMemLocationSeq, factMemLocationSeq);
    bool killFact = DataFlowUtils::isSubsetMemoryLocationSeq(dstMemLocationSeq, factMemLocationSeq);

    if (genFact) {
      const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                            srcMemLocationSeq);
      const auto relocatedMemLocationSeq = DataFlowUtils::joinMemoryLocationSeqs(dstMemLocationSeq,
                                                                                 relocatableMemLocationSeq);
      ExtendedValue ev(fact);
      ev.setMemLocationSeq(relocatedMemLocationSeq);

      targetFacts.insert(ev);
      traceStats.add(memTransferInst);

      llvm::outs() << "[TRACK] Relocated memory location (memcpy/memmove)" << "\n";
      llvm::outs() << "[TRACK] Source:" << "\n";
      DataFlowUtils::dumpFact(fact);
      llvm::outs() << "[TRACK] Destination:" << "\n";
      DataFlowUtils::dumpFact(ev);
    }
    if (!killFact) targetFacts.insert(fact);
  }

  return targetFacts;
}

} // namespace
