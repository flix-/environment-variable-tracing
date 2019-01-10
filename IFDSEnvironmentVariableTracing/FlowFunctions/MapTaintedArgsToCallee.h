#ifndef MAPTAINTEDARGSTOCALLEE_H
#define MAPTAINTEDARGSTOCALLEE_H

#include <llvm/IR/Instruction.h>
#include <llvm/IR/CallSite.h>

#include <phasar/PhasarLLVM/IfdsIde/FlowFunction.h>
#include <phasar/PhasarLLVM/IfdsIde/LLVMZeroValue.h>

namespace psr {

class MapTaintedArgsToCallee : public FlowFunction<const llvm::Value *> {
public:
  MapTaintedArgsToCallee(const llvm::CallInst* _callInst,
                         const llvm::Function* _destMthd,
                         std::map<const llvm::Value*, const llvm::Value*>& _argumentMappings,
                         const llvm::Value* _zeroValue)
    : callInst(_callInst),
      destMthd(_destMthd),
      argumentMappings(_argumentMappings),
      zeroValue(_zeroValue) {}
  ~MapTaintedArgsToCallee() override = default;

  std::set<const llvm::Value*>
  computeTargets(const llvm::Value *fact) override;

private:
  const llvm::CallInst* callInst;
  const llvm::Function* destMthd;
  std::map<const llvm::Value*, const llvm::Value*>& argumentMappings;
  const llvm::Value* zeroValue;
};

} // namespace
#endif // MAPTAINTEDARGSTOCALLEE_H
