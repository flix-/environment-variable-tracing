#ifndef DATAFLOWFACTS_H
#define DATAFLOWFACTS_H

#include <phasar/Config/ContainerConfiguration.h>

#include <llvm/IR/Value.h>

namespace psr {

class DataFlowFacts
{
public:
  DataFlowFacts() = delete;

  static bool isExactMemoryLocationTainted(const MonoSet<const llvm::Value*>& facts, const llvm::Value* value);
  static bool isValueInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::Value* value);
  static void removeExactMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::Value* memLocation);
  static const llvm::Value* findBranchOrSwitchInstInFacts(const MonoSet<const llvm::Value*>& facts);
};

} // namespace

#endif // DATAFLOWFACTS_H
