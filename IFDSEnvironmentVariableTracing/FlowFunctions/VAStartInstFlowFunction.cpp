/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#include "VAStartInstFlowFunction.h"

#include <llvm/IR/IntrinsicInst.h>

namespace psr {

std::set<ExtendedValue>
VAStartInstFlowFunction::computeTargetsExt(ExtendedValue& fact) {

  std::set<ExtendedValue> targetFacts;
  targetFacts.insert(fact);

  bool isVarArgTemplateFact = fact.isVarArgTemplate();
  if (!isVarArgTemplateFact) return targetFacts;

  const auto vaStartInst = llvm::cast<llvm::VAStartInst>(currentInst);
  const auto vaListMemLocationMatr = vaStartInst->getArgList();

  auto vaListMemLocationSeq = DataFlowUtils::getMemoryLocationSeqFromMatr(vaListMemLocationMatr);

  bool isValidMemLocationSeq = !vaListMemLocationSeq.empty();
  if (isValidMemLocationSeq) {
    bool isArrayDecay = DataFlowUtils::isArrayDecay(vaListMemLocationMatr);
    if (isArrayDecay) vaListMemLocationSeq.pop_back();

    ExtendedValue ev(fact);
    ev.setVaListMemLocationSeq(vaListMemLocationSeq);

    targetFacts.insert(ev);

//    llvm::outs() << "[TRACK] Created new VarArg from template" << "\n";
//    llvm::outs() << "[TRACK] Template:" << "\n";
//    DataFlowUtils::dumpFact(fact);
//    llvm::outs() << "[TRACK] VarArg:" << "\n";
//    DataFlowUtils::dumpFact(ev);
  }

  return targetFacts;
}

} // namespace
