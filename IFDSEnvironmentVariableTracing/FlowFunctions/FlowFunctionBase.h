/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef FLOWFUNCTIONBASE_H
#define FLOWFUNCTIONBASE_H

#include "../LineNumberStore.h"
#include "../Utils/DataFlowUtils.h"

#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>

#include <llvm/Support/raw_ostream.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunction.h>

namespace psr {

class FlowFunctionBase : public FlowFunction<ExtendedValue> {

public:
  FlowFunctionBase(const llvm::Instruction* _currentInst,
                   LineNumberStore& _lineNumberStore,
                   ExtendedValue _zeroValue)
    : currentInst(_currentInst),
      lineNumberStore(_lineNumberStore),
      zeroValue(_zeroValue) { }
  ~FlowFunctionBase() override = default;

  std::set<ExtendedValue> computeTargets(ExtendedValue fact) override;
  virtual std::set<ExtendedValue> computeTargetsExt(ExtendedValue& fact) = 0;

protected:
  const llvm::Instruction* currentInst;
  LineNumberStore& lineNumberStore;
  ExtendedValue zeroValue;
};

} // namespace

#endif // FLOWFUNCTIONBASE_H
