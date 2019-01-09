#ifndef FLOWFUNCTIONWRAPPER_H
#define FLOWFUNCTIONWRAPPER_H

#include "../LineNumberStore.h"

#include <functional>

#include <llvm/IR/Instruction.h>

#include <phasar/PhasarLLVM/IfdsIde/FlowFunction.h>

namespace psr {

using ComputeTargetsExtFunction = std::function<std::set<const llvm::Value*> (const llvm::Instruction* currentInst,
                                                                              const llvm::Value* fact,
                                                                              LineNumberStore& lineNumberStore,
                                                                              const llvm::Value* zeroValue)>;

class FlowFunctionWrapper : public FlowFunction<const llvm::Value*> {
public:
  FlowFunctionWrapper(const llvm::Instruction* _currentInst,
                      ComputeTargetsExtFunction _computeTargetsExt,
                      LineNumberStore& _lineNumberStore,
                      const llvm::Value* _zeroValue)
    : currentInst(_currentInst),
      computeTargetsExt(_computeTargetsExt),
      lineNumberStore(_lineNumberStore),
      zeroValue(_zeroValue) {}
  ~FlowFunctionWrapper() override = default;

  std::set<const llvm::Value*> computeTargets(const llvm::Value* fact) override;

private:
  const llvm::Instruction* currentInst;
  ComputeTargetsExtFunction computeTargetsExt;
  LineNumberStore& lineNumberStore;
  const llvm::Value* zeroValue;
};

} // namespace

#endif // FLOWFUNCTIONWRAPPER_H
