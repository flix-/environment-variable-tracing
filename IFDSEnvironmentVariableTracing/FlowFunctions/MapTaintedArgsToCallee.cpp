#include "MapTaintedArgsToCallee.h"

#include "../Utils/DataFlowUtils.h"

#include <llvm/Support/raw_ostream.h>

#include <phasar/Utils/LLVMShorthands.h>

namespace psr {

std::set<const llvm::Value*>
MapTaintedArgsToCallee::computeTargets(const llvm::Value *fact) {
  std::set<const llvm::Value*> mappedFormals;

  for (unsigned i = 0; i < callInst->getNumArgOperands(); i++) {
    const auto actualArgument = callInst->getOperand(i);
    /*
     * If actual argument ends in the same memory location frame as
     * fact map store instruction to formal argument.
     */
    bool isSameMemLocationFrame = DataFlowUtils::isMemoryLocationFrameEqual(fact, actualArgument, callerArgumentMappings);
    if (isSameMemLocationFrame) {
      const auto formalParameter = getNthFunctionArgument(destMthd, i);
      std::pair<const llvm::Value*, const llvm::Value*> argumentMapping(fact, formalParameter);
      calleeArgumentMappings.insert(argumentMapping);

      llvm::outs() << "Mapped" << "\n"; fact->print(llvm::outs()); llvm::outs() << "\n" << "to" << "\n"; formalParameter->print(llvm::outs()); llvm::outs() << "\n";

      mappedFormals.insert(fact);
    }
  }
  return { mappedFormals };
}

} // namespace
