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
                         const llvm::Value* _zeroValue);
  virtual ~MapTaintedArgsToCallee() override = default;

  std::set<const llvm::Value*>
  computeTargets(const llvm::Value *fact) override;

private:
  const llvm::CallInst* callInst;
  const llvm::Function* destMthd;
  const llvm::Value* zeroValue;
};

} // namespace
#endif // MAPTAINTEDARGSTOCALLEE_H
