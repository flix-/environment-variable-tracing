/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "MapTaintedValuesToCallee.h"

#include "../Utils/DataFlowUtils.h"

#include <llvm/Support/raw_ostream.h>

#include <phasar/Utils/LLVMShorthands.h>

namespace psr {

std::set<ExtendedValue>
MapTaintedValuesToCallee::computeTargets(ExtendedValue fact) {

  std::set<ExtendedValue> targetFacts;

  for (unsigned i = 0; i < callInst->getNumArgOperands(); ++i) {
    const auto actualArgument = callInst->getOperand(i);
    const auto formalParameter = getNthFunctionArgument(destMthd, i);

    auto srcMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(actualArgument);
    const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);

    /*
     * If the struct is coerced / decayed then the indexes are not matching up
     * anymore. E.g. if we have the following struct:
     *
     * struct s1 {
     *   int a;
     *   int b;
     *   char *t1;
     * };
     *
     * If we taint t1 we will have Alloca_x -> GEP 2 as our memory location.
     *
     * Now if a and b are coerced from i32, i32 to i64 we will have a struct
     * that only contains two members (i64, i8*). This means that also the
     * GEP indexes are different (there is no GEP 2 anymore). So we just ignore
     * the GEP value and pop it from the memory location and proceed as usual.
     */
    bool isCoerce = formalParameter->getName().contains_lower("coerce");
    if (isCoerce) {
      assert(srcMemLocationSeq.size() > 1);
      srcMemLocationSeq.pop_back();
    }

    bool genFact = DataFlowUtils::isSubsetMemoryLocationSeq(srcMemLocationSeq, factMemLocationSeq);
    if (genFact) {
      const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                            srcMemLocationSeq);
      std::vector<const llvm::Value*> dstMemLocationSeq{formalParameter};
      const auto relocatedMemLocationSeq = DataFlowUtils::joinMemoryLocationSeqs(dstMemLocationSeq,
                                                                                 relocatableMemLocationSeq);

      ExtendedValue ev(fact);
      ev.setMemLocationSeq(relocatedMemLocationSeq);

      targetFacts.insert(ev);
      lineNumberStore.addLineNumber(callInst);

      llvm::outs() << "[TRACK] Relocated memory location (call)" << "\n";
      llvm::outs() << "[TRACK] Source:" << "\n";
      DataFlowUtils::dumpMemoryLocation(fact);
      llvm::outs() << "[TRACK] Destination:" << "\n";
      DataFlowUtils::dumpMemoryLocation(ev);
    }
  }

  return targetFacts;
}

} // namespace
