#ifndef FLOWFUNCTIONWRAPPER_H
#define FLOWFUNCTIONWRAPPER_H

#include "../LineNumberStore.h"

#include <functional>
#include <map>

#include <llvm/IR/Instruction.h>

#include <phasar/PhasarLLVM/IfdsIde/FlowFunction.h>

namespace psr {

using ComputeTargetsExtFunction = std::function<std::set<const llvm::Value*> (const llvm::Instruction* currentInst,
                                                                              const llvm::Value* fact,
                                                                              std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                                              LineNumberStore& lineNumberStore,
                                                                              const llvm::Value* zeroValue)>;

class FlowFunctionWrapper : public FlowFunction<const llvm::Value*> {
public:
  FlowFunctionWrapper(const llvm::Instruction* _currentInst,
                      ComputeTargetsExtFunction _computeTargetsExt,
                      std::map<const llvm::Value*, const llvm::Value*>& _argumentMappings,
                      LineNumberStore& _lineNumberStore,
                      const llvm::Value* _zeroValue)
    : currentInst(_currentInst),
      computeTargetsExt(_computeTargetsExt),
      argumentMappings(_argumentMappings),
      lineNumberStore(_lineNumberStore),
      zeroValue(_zeroValue) { }
  ~FlowFunctionWrapper() override = default;

  std::set<const llvm::Value*> computeTargets(const llvm::Value* fact) override;

private:
  const llvm::Instruction* currentInst;
  ComputeTargetsExtFunction computeTargetsExt;
  std::map<const llvm::Value*, const llvm::Value*>& argumentMappings;
  LineNumberStore& lineNumberStore;
  const llvm::Value* zeroValue;
};

} // namespace

#endif // FLOWFUNCTIONWRAPPER_H
