#ifndef DATAFLOWUTILS_H
#define DATAFLOWUTILS_H

#include <llvm/IR/Instructions.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>

namespace psr {

class DataFlowUtils {
public:
  DataFlowUtils() = delete;

  static bool isValueEqual(const ExtendedValue& fact, const llvm::Value* instruction);
  static bool isMemoryLocationEqual(const ExtendedValue& fact, const llvm::Value* memLocationInst);
  static bool isMemoryLocationFrameEqual(const ExtendedValue& fact, const llvm::Value* memLocationInst);
  static bool isEndOfBranchOrSwitchInst(const ExtendedValue& fact, const llvm::Instruction* instruction);

};

} // namespace

#endif // DATAFLOWUTILS_H
