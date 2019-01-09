#include "MapTaintedArgsToCallee.h"

#include <llvm/Support/raw_ostream.h>

#include <phasar/Utils/LLVMShorthands.h>

namespace psr {

MapTaintedArgsToCallee::MapTaintedArgsToCallee(const llvm::CallInst* _callInst,
                                               const llvm::Function* _destMthd,
                                               const llvm::Value* _zeroValue) : callInst(_callInst), destMthd(_destMthd), zeroValue(_zeroValue) {}

std::set<const llvm::Value*>
MapTaintedArgsToCallee::computeTargets(const llvm::Value *fact) {
  std::set<const llvm::Value*> mappedFormalParameters;

  bool isZeroFact = fact == zeroValue;
  if (isZeroFact) {
    for (unsigned i = 0; i < callInst->getNumArgOperands(); i++) {
      const auto actualArgument = callInst->getOperand(i);
      bool isTainted = actualArgument != nullptr;
      if (isTainted) {
        const auto formalParameter = getNthFunctionArgument(destMthd, i);
        mappedFormalParameters.insert(formalParameter);
      }
    }
  }
  return mappedFormalParameters;
}

} // namespace
