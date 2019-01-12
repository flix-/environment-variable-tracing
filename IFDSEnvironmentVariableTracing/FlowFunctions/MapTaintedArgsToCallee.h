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
                         const std::map<const llvm::Value*, const llvm::Value*>& _callerArgumentMappings,
                         std::map<const llvm::Value*, const llvm::Value*>& _calleeArgumentMappings,
                         LineNumberStore& _lineNumberStore,
                         ExtendedValue& _zeroValue)
    : callInst(_callInst),
      destMthd(_destMthd),
      callerArgumentMappings(_callerArgumentMappings),
      calleeArgumentMappings(_calleeArgumentMappings),
      lineNumberStore(_lineNumberStore),
      zeroValue(_zeroValue) {}
  ~MapTaintedArgsToCallee() override = default;

  std::set<ExtendedValue>
  computeTargets(ExtendedValue fact) override;

private:
  const llvm::CallInst* callInst;
  const llvm::Function* destMthd;
  const std::map<const llvm::Value*, const llvm::Value*>& callerArgumentMappings;
  std::map<const llvm::Value*, const llvm::Value*>& calleeArgumentMappings;
  LineNumberStore& lineNumberStore;
  ExtendedValue& zeroValue;
};

} // namespace
#endif // MAPTAINTEDARGSTOCALLEE_H
