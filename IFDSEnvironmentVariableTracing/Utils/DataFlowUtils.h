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
  static bool isMemoryLocationFrameEqual(const ExtendedValue& fact,
                                         const llvm::Value* memLocationMatr);

  static const std::vector<const llvm::Value*> getMemoryLocationSeqFromMatr(const llvm::Value* memLocationMatr);
  static const std::vector<const llvm::Value*> getMemoryLocationSeqFromFact(const ExtendedValue& memLocationFact);

  static const llvm::Value* getMemoryLocationFrameFromMatr(const llvm::Value* memLocationMatr);
  static const llvm::Value* getMemoryLocationFrameFromFact(const ExtendedValue& fact);

  static bool isSubsetMemoryLocationSeq(const std::vector<const llvm::Value*> memLocationSeqInst,
                                        const std::vector<const llvm::Value*> memLocationSeqFact);
  static const std::vector<const llvm::Value*> getRelocatableMemoryLocationSeq(const std::vector<const llvm::Value*> taintedMemLocationSeq,
                                                                               const std::vector<const llvm::Value*> srcMemLocationSeq);
  static const std::vector<const llvm::Value*> joinMemoryLocationSeqs(const std::vector<const llvm::Value*> memLocationSeq1,
                                                                      const std::vector<const llvm::Value*> memLocationSeq2);

  static std::string getEndOfBlockLabel(const llvm::Instruction* instruction);
  static std::string getBBLabel(const llvm::Instruction* instruction);

  static bool isAutoGENInTaintedBlock(const llvm::Instruction* instruction);

  static bool isCalleePatch(const llvm::Value* storeInstSrcValue, ExtendedValue& fact);

  static bool isMemoryLocation(const ExtendedValue& ev);
  static void dumpMemoryLocation(const ExtendedValue& ev);
  static std::string getTypeName(const llvm::Type* type);

};

} // namespace

#endif // DATAFLOWUTILS_H
