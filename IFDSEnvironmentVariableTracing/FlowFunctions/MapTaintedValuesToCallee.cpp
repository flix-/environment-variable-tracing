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

    bool isArgCoerced = formalParameter->getName().contains_lower("coerce");

    bool isArgTrivial = DataFlowUtils::isPrimitiveType(actualArgument->getType()) && !isArgCoerced;

    if (isArgTrivial) {
      bool isArgTainted = DataFlowUtils::isValueTainted(fact, actualArgument);
      if (isArgTainted) {
        ExtendedValue ev(formalParameter);
        ev.setMemLocationSeq(std::vector<const llvm::Value*>{formalParameter});

        targetFacts.insert(ev);
      }
    }
    else {
      const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);
      auto argMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(actualArgument);

      /*
       * If the struct is coerced then the indexes are not matching up anymore.
       * E.g. if we have the following struct:
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
      if (isArgCoerced) {
        assert(argMemLocationSeq.size() > 1);
        argMemLocationSeq.pop_back();
      }

      bool genFact = DataFlowUtils::isSubsetMemoryLocationSeq(argMemLocationSeq,
                                                              factMemLocationSeq);
      if (genFact) {
        const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                              argMemLocationSeq);
        std::vector<const llvm::Value*> patchablePart{formalParameter};
        const auto patchableMemLocationSeq = DataFlowUtils::joinMemoryLocationSeqs(patchablePart,
                                                                                   relocatableMemLocationSeq);

        ExtendedValue ev(fact);
        ev.setMemLocationSeq(patchableMemLocationSeq);

        targetFacts.insert(ev);

        llvm::outs() << "[TRACK] Relocated memory location (caller -> callee)" << "\n";
        llvm::outs() << "[TRACK] Source:" << "\n";
        DataFlowUtils::dumpMemoryLocation(fact);
        llvm::outs() << "[TRACK] Destination:" << "\n";
        DataFlowUtils::dumpMemoryLocation(ev);
      }
    }
  }

  bool addLineNumber = !targetFacts.empty();
  if (addLineNumber) {
    lineNumberStore.addLineNumber(callInst);
  }

  return targetFacts;
}

} // namespace
