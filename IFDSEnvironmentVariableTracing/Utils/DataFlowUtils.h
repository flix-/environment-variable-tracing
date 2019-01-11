#ifndef DATAFLOWUTILS_H
#define DATAFLOWUTILS_H

#include <llvm/IR/Instructions.h>

#include <phasar/Config/ContainerConfiguration.h>

namespace psr {

class DataFlowUtils {
public:
  DataFlowUtils() = delete;

  static bool isValueEqual(const llvm::Value* fact,
                           const llvm::Value* inst);
  static bool isMemoryLocationEqual(const llvm::Value* fact,
                                    const llvm::Value* memLocationInst,
                                    const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings);
  static bool isMemoryLocationFrameEqual(const llvm::Value* fact,
                                         const llvm::Value* memLocationInst,
                                         const std::map<const llvm::Value*, const llvm::Value*>& argumentMappings);
  static bool isEndOfBranchOrSwitchInst(const llvm::Value* branchOrSwitchInst,
                                        const llvm::Instruction* inst);
  static void dumpFacts(const MonoSet<const llvm::Value*>& facts);
  static void logToFile(const char*);
};

} // namespace

#endif // DATAFLOWUTILS_H
