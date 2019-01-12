#ifndef IDENTITY_H
#define IDENTITY_H

#include "FlowFunctionWrapper.h"

#include <memory>

namespace psr {

class Identity {
public:
  Identity() = delete;

  static std::shared_ptr<FlowFunctionWrapper> getInstance(const llvm::Instruction* currentInst,
                                                          const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                          LineNumberStore& lineNumberStore,
                                                          ExtendedValue& zeroValue) {

    ComputeTargetsExtFunction identityFlowFunction = [](const llvm::Instruction* currentInst,
                                                        ExtendedValue& fact,
                                                        const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                        LineNumberStore& lineNumberStore,
                                                        ExtendedValue& zeroValue) -> std::set<ExtendedValue> {
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, identityFlowFunction, argumentMappings, lineNumberStore, zeroValue);
  }
};

} // namespace

#endif // IDENTITY_H
