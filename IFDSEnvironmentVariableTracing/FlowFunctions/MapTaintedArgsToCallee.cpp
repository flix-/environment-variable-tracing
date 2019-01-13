#include "MapTaintedArgsToCallee.h"

#include "../Utils/DataFlowUtils.h"

#include <llvm/Support/raw_ostream.h>

#include <phasar/Utils/LLVMShorthands.h>

namespace psr {

std::set<ExtendedValue>
MapTaintedArgsToCallee::computeTargets(ExtendedValue fact) {

  std::set<ExtendedValue> mappedFormals;

  for (unsigned i = 0; i < callInst->getNumArgOperands(); i++) {
    const auto actualArgument = callInst->getOperand(i);
    /*
     * If actual argument ends in the same memory location frame as
     * fact add fact and map store instruction to formal argument.
     */
    bool isSameMemLocationFrame = DataFlowUtils::isMemoryLocationFrameEqual(fact, actualArgument);
    if (isSameMemLocationFrame) {
      const auto formalParameter = getNthFunctionArgument(destMthd, i);
      fact.setPatchedMemLocationFrame(formalParameter);
      mappedFormals.insert(fact);

      lineNumberStore.addLineNumber(callInst);

      llvm::outs() << "Mapped" << "\n"; fact.getValue()->print(llvm::outs()); llvm::outs() << "\n" << "to" << "\n"; formalParameter->print(llvm::outs()); llvm::outs() << "\n";
    }
  }
  return { mappedFormals };
}

} // namespace
