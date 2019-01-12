#ifndef IDENTITY_H
#define IDENTITY_H

#include "FlowFunctionWrapper.h"

#include <memory>

namespace psr {

class Identity {
public:
  Identity() = delete;

  static std::shared_ptr<FlowFunctionWrapper> getInstance(const llvm::Instruction* currentInst,
                                                          LineNumberStore& lineNumberStore,
                                                          ExtendedValue zeroValue) {

    ComputeTargetsExtFunction identityFlowFunction = [](const llvm::Instruction* currentInst,
                                                        ExtendedValue& fact,
                                                        LineNumberStore& lineNumberStore,
                                                        ExtendedValue& zeroValue) -> std::set<ExtendedValue> {
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, identityFlowFunction, lineNumberStore, zeroValue);
  }
};

} // namespace

#endif // IDENTITY_H
