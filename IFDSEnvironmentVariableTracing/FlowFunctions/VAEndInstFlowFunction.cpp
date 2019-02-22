/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "VAEndInstFlowFunction.h"

#include <llvm/IR/IntrinsicInst.h>

namespace psr {

std::set<ExtendedValue>
VAEndInstFlowFunction::computeTargetsExt(ExtendedValue& fact) {

  bool isVarArgFact = fact.isVarArg();
  if (!isVarArgFact) return { fact };

  const auto vaEndInst = llvm::cast<llvm::VAEndInst>(currentInst);
  const auto vaEndMemLocationMatr = vaEndInst->getArgList();

  const auto vaEndMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(vaEndMemLocationMatr);

  bool isValidMemLocationSeq = !vaEndMemLocationSeq.empty();
  if (isValidMemLocationSeq) {
    bool isVaListEqual = DataFlowUtils::isMemoryLocationSeqsEqual(DataFlowUtils::getVaListMemoryLocationSeqFromFact(fact),
                                                                  vaEndMemLocationSeq);
    if (isVaListEqual) {
      llvm::outs() << "[TRACK] Killed VarArg" << "\n";
      DataFlowUtils::dumpFact(fact);

      return { };
    }
  }

  return { fact };
}

} // namespace
