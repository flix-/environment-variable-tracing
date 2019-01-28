/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "MapTaintedValuesToCallee.h"

#include "../Utils/DataFlowUtils.h"

#include <tuple>

#include <llvm/Support/raw_ostream.h>

#include <phasar/Utils/LLVMShorthands.h>

namespace psr {

std::set<ExtendedValue>
MapTaintedValuesToCallee::computeTargets(ExtendedValue fact) {

  std::set<ExtendedValue> targetFacts;

  long varArgIndex = 0L;

  const auto sanitizedArgList = DataFlowUtils::getSanitizedArgList(callInst,
                                                                   destMthd,
                                                                   zeroValue.getValue());
  for (const auto& argParamTriple : sanitizedArgList) {

    const auto arg = std::get<0>(argParamTriple);
    const auto argMemLocationSeq = std::get<1>(argParamTriple);
    const auto param = std::get<2>(argParamTriple);

    bool isVarArg = param == zeroValue.getValue();

    bool isArgMemLocation = !argMemLocationSeq.empty();
    if (isArgMemLocation) {
      const auto factMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromFact(fact);

      bool genFact = DataFlowUtils::isSubsetMemoryLocationSeq(argMemLocationSeq,
                                                              factMemLocationSeq);
      if (genFact) {
        const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                              argMemLocationSeq);
        std::vector<const llvm::Value*> patchablePart{param};
        const auto patchableMemLocationSeq = DataFlowUtils::joinMemoryLocationSeqs(patchablePart,
                                                                                   relocatableMemLocationSeq);

        ExtendedValue ev(param);
        ev.setMemLocationSeq(patchableMemLocationSeq);
        if (isVarArg) ev.setVarArgIndex(varArgIndex);

        targetFacts.insert(ev);

        llvm::outs() << "[TRACK] Added patchable memory location (caller -> callee)" << "\n";
        llvm::outs() << "[TRACK] Source:" << "\n";
        DataFlowUtils::dumpMemoryLocation(fact);
        llvm::outs() << "[TRACK] Destination:" << "\n";
        DataFlowUtils::dumpMemoryLocation(ev);
      }
    }
    else {
      bool isArgTainted = DataFlowUtils::isValueTainted(fact, arg);
      if (isArgTainted) {
        std::vector<const llvm::Value*> patchablePart{param};

        ExtendedValue ev(param);
        ev.setMemLocationSeq(patchablePart);
        if (isVarArg) ev.setVarArgIndex(varArgIndex);

        targetFacts.insert(ev);

        llvm::outs() << "[TRACK] Added patchable memory location (caller -> callee)" << "\n";
        llvm::outs() << "[TRACK] Source:" << "\n";
        DataFlowUtils::dumpMemoryLocation(fact);
        llvm::outs() << "[TRACK] Destination:" << "\n";
        DataFlowUtils::dumpMemoryLocation(ev);
      }
    }

    if (isVarArg) ++varArgIndex;
  }

  bool addLineNumber = !targetFacts.empty();
  if (addLineNumber) {
    lineNumberStore.addLineNumber(callInst);
  }

  return targetFacts;
}

} // namespace
