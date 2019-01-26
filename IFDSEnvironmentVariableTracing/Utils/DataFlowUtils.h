/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef DATAFLOWUTILS_H
#define DATAFLOWUTILS_H

#include <string>
#include <vector>

#include <llvm/IR/Instructions.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>

namespace psr {

class DataFlowUtils {
public:
  DataFlowUtils() = delete;

  static bool isValueTainted(const ExtendedValue& fact,
                             const llvm::Value* instruction);

  static bool isMemoryLocationTainted(const ExtendedValue& fact,
                                      const llvm::Value* memLocationMatr);

  static const std::vector<const llvm::Value*> getMemoryLocationSeqFromMatr(const llvm::Value* memLocationMatr);
  static const std::vector<const llvm::Value*> getMemoryLocationSeqFromFact(const ExtendedValue& memLocationFact);

  static bool isSubsetMemoryLocationSeq(const std::vector<const llvm::Value*> memLocationSeqInst,
                                        const std::vector<const llvm::Value*> memLocationSeqFact);
  static const std::vector<const llvm::Value*> getRelocatableMemoryLocationSeq(const std::vector<const llvm::Value*> taintedMemLocationSeq,
                                                                               const std::vector<const llvm::Value*> srcMemLocationSeq);
  static const std::vector<const llvm::Value*> joinMemoryLocationSeqs(const std::vector<const llvm::Value*> memLocationSeq1,
                                                                      const std::vector<const llvm::Value*> memLocationSeq2);

  static bool isPatchableArgument(const llvm::Value* storeInstSrcValue,
                                  ExtendedValue& fact);
  static bool isPatchableReturnValue(const llvm::Value* storeInstSrcValue,
                                     ExtendedValue& fact);
  static const std::vector<const llvm::Value*> patchMemoryLocationFrame(const std::vector<const llvm::Value*> patchableMemLocationSeq,
                                                                        const std::vector<const llvm::Value*> patchMemLocationSeq);

  static std::string getEndOfBlockLabel(const llvm::Instruction* instruction);
  static std::string getBBLabel(const llvm::Instruction* instruction);

  static bool isAutoGENInTaintedBlock(const llvm::Instruction* instruction);

  static bool isMemoryLocationFact(const ExtendedValue& ev);
  static void dumpMemoryLocation(const ExtendedValue& ev);
  static std::string getTypeName(const llvm::Type* type);

};

} // namespace

#endif // DATAFLOWUTILS_H
