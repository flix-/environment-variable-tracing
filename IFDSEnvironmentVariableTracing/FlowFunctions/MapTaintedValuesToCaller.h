#ifndef MAPTAINTEDVALUESTOCALLER_H
#define MAPTAINTEDVALUESTOCALLER_H

#include "../LineNumberStore.h"

#include <llvm/IR/Instructions.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunction.h>
#include <phasar/PhasarLLVM/IfdsIde/LLVMZeroValue.h>

namespace psr {

class MapTaintedValuesToCaller : public FlowFunction<ExtendedValue> {
public:
  MapTaintedValuesToCaller(const llvm::CallInst* _callInst,
                           const llvm::ReturnInst* _retInst,
                           LineNumberStore& _lineNumberStore,
                           ExtendedValue _zeroValue)
    : callInst(_callInst),
      retInst(_retInst),
      lineNumberStore(_lineNumberStore),
      zeroValue(_zeroValue) {}
  ~MapTaintedValuesToCaller() override = default;

  std::set<ExtendedValue>
  computeTargets(ExtendedValue fact) override;

private:
  const llvm::CallInst* callInst;
  const llvm::ReturnInst* retInst;
  LineNumberStore& lineNumberStore;
  ExtendedValue zeroValue;
};

} // namespace

#endif // MAPTAINTEDVALUESTOCALLER_H

