#ifndef DATAFLOWUTILS_H
#define DATAFLOWUTILS_H

#include <vector>

#include <llvm/IR/Instructions.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>

namespace psr {

class DataFlowUtils {
public:
  DataFlowUtils() = delete;

  static bool isValueEqual(const ExtendedValue& fact,
                           const llvm::Value* instruction);

  static bool isMemoryLocationEqual(const ExtendedValue& fact,
                                    const llvm::Value* memLocationMatr);
  static bool isMemoryLocationFrameEqual(const ExtendedValue& fact,
                                         const llvm::Value* memLocationMatr);

  static const std::vector<const llvm::Value*> getMemoryLocationSeqFromMatr(const llvm::Value* memLocationMatr);

  static const llvm::Value* getMemoryLocationFrameFromMatr(const llvm::Value* memLocationMatr);

  /**
   * @brief                 Determine whether the memory location sequence of @p memLocationMatr
   *                        is a subset of the memory location sequence of @p fact.
   * @param memLocationMatr Memory location matryoshka.
   * @param fact            Fact holding a memory locations sequence.
   * @return                The memory location sequence belonging to @p memLocationMatr if @p memLocationMatr
   *                        is a subset of @p fact and an empty vector otherwise.
   */
  static const std::vector<const llvm::Value*> getSubsetMemoryLocationSeq(const llvm::Value* memLocationMatr,
                                                                          const ExtendedValue& fact);

  static const std::vector<const llvm::Value*> createRelocatedMemoryLocationSeq(const std::vector<const llvm::Value*> taintedMemLocationSeq,
                                                                                const std::vector<const llvm::Value*> dstMemLocationSeq,
                                                                                std::size_t skipPartsInTaintedCount);
  static void dumpMemoryLocation(const ExtendedValue& ev);

  static bool isMemoryLocationFact(const ExtendedValue& ev);
  static bool isEndOfBranchOrSwitchInst(const ExtendedValue& fact,
                                        const llvm::Instruction* instruction);

};

} // namespace

#endif // DATAFLOWUTILS_H
