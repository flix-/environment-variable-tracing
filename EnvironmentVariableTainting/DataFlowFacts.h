#ifndef DATAFLOWFACTS_H
#define DATAFLOWFACTS_H

#include <phasar/Config/ContainerConfiguration.h>

#include <llvm/IR/Value.h>

namespace psr {

class DataFlowFacts
{
public:
  DataFlowFacts() = delete;

  static bool isValueTainted(const MonoSet<const llvm::Value*>& facts, const llvm::Value* value);
  static bool isMemoryLocationTainted(const MonoSet<const llvm::Value*>& facts, const llvm::Value* memLocation);
  static unsigned long removeMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::Value* memLocation);
  static const llvm::Value* findBranchOrSwitchInstInFacts(const MonoSet<const llvm::Value*>& facts);
};

} // namespace

#endif // DATAFLOWFACTS_H
