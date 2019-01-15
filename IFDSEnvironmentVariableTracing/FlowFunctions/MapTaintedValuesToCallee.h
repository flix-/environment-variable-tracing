#ifndef MAPTAINTEDVALUESTOCALLEE_H
#define MAPTAINTEDVALUESTOCALLEE_H

#include "../LineNumberStore.h"

#include <llvm/IR/Instruction.h>
#include <llvm/IR/CallSite.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunction.h>
#include <phasar/PhasarLLVM/IfdsIde/LLVMZeroValue.h>

namespace psr {

class MapTaintedValuesToCallee : public FlowFunction<ExtendedValue> {
public:
  MapTaintedValuesToCallee(const llvm::CallInst* _callInst,
                           const llvm::Function* _destMthd,
                           LineNumberStore& _lineNumberStore,
                           ExtendedValue _zeroValue)
    : callInst(_callInst),
      destMthd(_destMthd),
      lineNumberStore(_lineNumberStore),
      zeroValue(_zeroValue) {}
  ~MapTaintedValuesToCallee() override = default;

  std::set<ExtendedValue>
  computeTargets(ExtendedValue fact) override;

private:
  const llvm::CallInst* callInst;
  const llvm::Function* destMthd;
  LineNumberStore& lineNumberStore;
  ExtendedValue zeroValue;
};

} // namespace

#endif // MAPTAINTEDVALUESTOCALLEE_H
