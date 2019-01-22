/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef FLOWFUNCTIONWRAPPER_H
#define FLOWFUNCTIONWRAPPER_H

#include "../LineNumberStore.h"

#include <functional>
#include <map>

#include <llvm/IR/Instruction.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>
#include <phasar/PhasarLLVM/IfdsIde/FlowFunction.h>

namespace psr {

using ComputeTargetsExtFunction = std::function<std::set<ExtendedValue> (const llvm::Instruction* currentInst,
                                                                         ExtendedValue& fact,
                                                                         LineNumberStore& lineNumberStore,
                                                                         ExtendedValue& zeroValue)>;

class FlowFunctionWrapper : public FlowFunction<ExtendedValue> {
public:
  FlowFunctionWrapper(const llvm::Instruction* _currentInst,
                      ComputeTargetsExtFunction _computeTargetsExt,
                      LineNumberStore& _lineNumberStore,
                      ExtendedValue _zeroValue)
    : currentInst(_currentInst),
      computeTargetsExt(_computeTargetsExt),
      lineNumberStore(_lineNumberStore),
      zeroValue(_zeroValue) { }
  ~FlowFunctionWrapper() override = default;

  std::set<ExtendedValue> computeTargets(ExtendedValue fact) override;

private:
  const llvm::Instruction* currentInst;
  ComputeTargetsExtFunction computeTargetsExt;
  LineNumberStore& lineNumberStore;
  ExtendedValue zeroValue;
};

} // namespace

#endif // FLOWFUNCTIONWRAPPER_H
