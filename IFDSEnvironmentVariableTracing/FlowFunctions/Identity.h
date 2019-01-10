#ifndef IDENTITY_H
#define IDENTITY_H

#include "FlowFunctionWrapper.h"

#include <memory>

namespace psr {

class Identity {
public:
  Identity() = delete;

  static std::shared_ptr<FlowFunctionWrapper> getInstance(const llvm::Instruction* currentInst,
                                                          std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                          LineNumberStore& lineNumberStore,
                                                          const llvm::Value* zeroValue) {

    ComputeTargetsExtFunction identityFlowFunction = [](const llvm::Instruction* currentInst,
                                                        const llvm::Value* fact,
                                                        std::map<const llvm::Value*, const llvm::Value*>& argumentMappings,
                                                        LineNumberStore& lineNumberStore,
                                                        const llvm::Value* zeroValue) -> std::set<const llvm::Value*> {
      return { fact };
    };

    return std::make_shared<FlowFunctionWrapper>(currentInst, identityFlowFunction, argumentMappings, lineNumberStore, zeroValue);
  }
};

} // namespace

#endif // IDENTITY_H
