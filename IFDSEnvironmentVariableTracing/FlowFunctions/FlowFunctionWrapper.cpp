/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "FlowFunctionWrapper.h"

#include "../Utils/DataFlowUtils.h"

#include <llvm/IR/IntrinsicInst.h>

namespace psr {

std::set<ExtendedValue>
FlowFunctionWrapper::computeTargets(ExtendedValue fact) {

  bool isBranchOrSwitchFact = llvm::isa<llvm::BranchInst>(fact.getValue()) ||
                              llvm::isa<llvm::SwitchInst>(fact.getValue());

  if (isBranchOrSwitchFact) {
    std::string basicBlockLabel = DataFlowUtils::getBBLabel(currentInst);

    /*
     * We are removing the tainted branch instruction from facts if the instruction's
     * basic block label matches the one of the trainted branch end block. Note that
     * we remove it after the phi node making sure that the phi node is auto added
     * whenever we came from a tainted branch.
     */
    bool isEndOfTaintedBlock = !llvm::isa<llvm::PHINode>(currentInst) &&
                               basicBlockLabel == fact.getEndOfTaintedBlockLabel();
    if (isEndOfTaintedBlock) return { };

    lineNumberStore.addLineNumber(currentInst);

    bool isAutoGEN = DataFlowUtils::isAutoGENInTaintedBlock(currentInst);
    if (isAutoGEN) return { fact, ExtendedValue(currentInst) };

    std::set<ExtendedValue> targetFacts;
    targetFacts.insert(fact);

    /*
     * We are only intercepting the branch fact here. All other facts will still be
     * evaluated according to the flow function's logic. This means that e.g. every
     * valid memory instruction (i.e. if src is tainted -> memory location is added)
     * will still gen/kill/id facts. Actually those functions do not have any clue that
     * they behave in a tainted block and there is no way to provide this knowledge due
     * to the distributive property of IFDS.
     *
     * The only cases we need to consider here is the addition of store facts that would
     * not be added in the regular case. In particular all cases where the src is not
     * tainted and the store fact is killed.
     *
     * Note that there is no way to relocate memory addresses here as we are dealing with
     * untainted sources. This means that if e.g. we add a struct then all subparts of it
     * are considered tainted. This should be the only spot where such memory locations
     * are generated.
     */
    if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(currentInst)) {
      ExtendedValue ev(currentInst);
      const auto memLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(storeInst->getPointerOperand());
      ev.setMemLocationSeq(memLocationSeq);

      targetFacts.insert(ev);
    }
    else
    if (const auto memTransferInst = llvm::dyn_cast<llvm::MemTransferInst>(currentInst)) {
      ExtendedValue ev(currentInst);
      const auto memLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(memTransferInst->getRawDest());
      ev.setMemLocationSeq(memLocationSeq);

      targetFacts.insert(ev);
    }

    return targetFacts;
  }

  return computeTargetsExt(currentInst, fact, lineNumberStore, zeroValue);
}

} // namespace
