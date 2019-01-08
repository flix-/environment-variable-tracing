#ifndef DATAFLOWUTILS_H
#define DATAFLOWUTILS_H

#include <llvm/IR/Instructions.h>

#include <phasar/Config/ContainerConfiguration.h>

namespace psr {

class DataFlowUtils
{
public:
  DataFlowUtils() = delete;

  static bool isEndOfBranchOrSwitchInst(const llvm::Value *branchOrSwitchInst, const llvm::Instruction *instruction);
  static void dumpFacts(const MonoSet<const llvm::Value*>& facts);
};

} // namespace

#endif // DATAFLOWUTILS_H
