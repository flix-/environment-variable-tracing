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

  bool isFactVarArgTemplate = fact.isVarArgTemplate();
  if (isFactVarArgTemplate) return { };

  std::set<ExtendedValue> targetFacts;

  long varArgIndex = 0L;

  const auto sanitizedArgList = DataFlowUtils::getSanitizedArgList(callInst, destMthd, zeroValue.getValue());

  for (const auto& argParamTriple : sanitizedArgList) {

    const auto arg = std::get<0>(argParamTriple);
    const auto argMemLocationSeq = std::get<1>(argParamTriple);
    const auto param = std::get<2>(argParamTriple);

    bool isVarArgParam = DataFlowUtils::isVarArgParam(param, zeroValue.getValue());
    bool isVarArgFact = fact.isVarArg();

    bool isArgMemLocation = !argMemLocationSeq.empty();
    if (isArgMemLocation) {

      const auto factMemLocationSeq = isVarArgFact ? DataFlowUtils::getVaListMemoryLocationSeqFromFact(fact) :
                                                     DataFlowUtils::getMemoryLocationSeqFromFact(fact);

      bool genFact = DataFlowUtils::isSubsetMemoryLocationSeq(argMemLocationSeq,
                                                              factMemLocationSeq);
      if (genFact) {
        const auto relocatableMemLocationSeq = DataFlowUtils::getRelocatableMemoryLocationSeq(factMemLocationSeq,
                                                                                              argMemLocationSeq);
        std::vector<const llvm::Value*> patchablePart{ param };
        const auto patchableMemLocationSeq = DataFlowUtils::joinMemoryLocationSeqs(patchablePart,
                                                                                   relocatableMemLocationSeq);

        ExtendedValue ev(fact);
        if (isVarArgFact) {
          ev.setVaListMemLocationSeq(patchableMemLocationSeq);
        }
        else {
          ev.setMemLocationSeq(patchableMemLocationSeq);
        }

        if (isVarArgParam) ev.setVarArgIndex(varArgIndex);

        targetFacts.insert(ev);

        llvm::outs() << "[TRACK] Added patchable memory location (caller -> callee)" << "\n";
        llvm::outs() << "[TRACK] Source:" << "\n";
        DataFlowUtils::dumpFact(fact);
        llvm::outs() << "[TRACK] Destination:" << "\n";
        DataFlowUtils::dumpFact(ev);
      }
    }
    else {
      bool isArgTainted = DataFlowUtils::isValueTainted(arg, fact);
      if (isArgTainted) {
        std::vector<const llvm::Value*> patchablePart{ param };

        ExtendedValue ev(fact);
        ev.setMemLocationSeq(patchablePart);
        if (isVarArgParam) ev.setVarArgIndex(varArgIndex);

        targetFacts.insert(ev);

        llvm::outs() << "[TRACK] Added patchable memory location (caller -> callee)" << "\n";
        llvm::outs() << "[TRACK] Source:" << "\n";
        DataFlowUtils::dumpFact(fact);
        llvm::outs() << "[TRACK] Destination:" << "\n";
        DataFlowUtils::dumpFact(ev);
      }
    }

    if (isVarArgParam) ++varArgIndex;
  }

  bool addLineNumber = !targetFacts.empty();
  if (addLineNumber) {
    lineNumberStore.addLineNumber(callInst);
  }

  return targetFacts;
}

} // namespace
