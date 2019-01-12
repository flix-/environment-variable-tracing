#ifndef MAPTAINTEDARGSTOCALLEE_H
#define MAPTAINTEDARGSTOCALLEE_H

#include "../LineNumberStore.h"

#include <llvm/IR/Instruction.h>
#include <llvm/IR/CallSite.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunction.h>
#include <phasar/PhasarLLVM/IfdsIde/LLVMZeroValue.h>

namespace psr {

class MapTaintedArgsToCallee : public FlowFunction<ExtendedValue> {
public:
  MapTaintedArgsToCallee(const llvm::CallInst* _callInst,
                         const llvm::Function* _destMthd,
                         LineNumberStore& _lineNumberStore,
                         ExtendedValue _zeroValue)
    : callInst(_callInst),
      destMthd(_destMthd),
      lineNumberStore(_lineNumberStore),
      zeroValue(_zeroValue) {}
  ~MapTaintedArgsToCallee() override = default;

  std::set<ExtendedValue>
  computeTargets(ExtendedValue fact) override;

private:
  const llvm::CallInst* callInst;
  const llvm::Function* destMthd;
  LineNumberStore& lineNumberStore;
  ExtendedValue zeroValue;
};

} // namespace
#endif // MAPTAINTEDARGSTOCALLEE_H
