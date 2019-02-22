/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "CheckOperandsFlowFunction.h"

namespace psr {

std::set<ExtendedValue>
CheckOperandsFlowFunction::computeTargetsExt(ExtendedValue& fact) {

  for (const auto& use : currentInst->operands()) {
    const auto& operand = use.get();

    bool isOperandTainted = DataFlowUtils::isValueTainted(operand, fact) ||
                            DataFlowUtils::isMemoryLocationTainted(operand, fact);
    if (isOperandTainted) {
      lineNumberStore.addLineNumber(currentInst);

      return { fact, ExtendedValue(currentInst) };
    }
  }

  return { fact };
}

} // namespace
