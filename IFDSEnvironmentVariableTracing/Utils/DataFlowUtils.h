/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef DATAFLOWUTILS_H
#define DATAFLOWUTILS_H

#include <string>
#include <set>
#include <tuple>
#include <vector>

#include <llvm/IR/Instructions.h>

#include <phasar/PhasarLLVM/Domain/ExtendedValue.h>

namespace psr {

class DataFlowUtils {
public:
  DataFlowUtils() = delete;

  static bool isValueTainted(const ExtendedValue& fact,
                             const llvm::Value* currentInst);

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

  static bool isPatchableArgumentStore(const llvm::Value* srcValue,
                                       ExtendedValue& fact);
  static bool isPatchableArgumentMemcpy(const llvm::Value* srcValue,
                                        const std::vector<const llvm::Value*> srcMemLocationSeq,
                                        ExtendedValue& fact);
  static bool isPatchableReturnValue(const llvm::Value* srcValue,
                                     ExtendedValue& fact);
  static const std::vector<const llvm::Value*> patchMemoryLocationFrame(const std::vector<const llvm::Value*> patchableMemLocationSeq,
                                                                        const std::vector<const llvm::Value*> patchMemLocationSeq);

  static const std::vector<std::tuple<const llvm::Value*,
                           const std::vector<const llvm::Value*>,
                           const llvm::Value*>>
              getSanitizedArgList(const llvm::CallInst* callInst,
                                  const llvm::Function* destMthd,
                                  const llvm::Value* zeroValue);

  static const llvm::BasicBlock* getEndOfBlockBB(const llvm::Instruction* currentInst);
  static const std::set<std::string> getSuccessorLabels(const llvm::BasicBlock* basicBlock);
  static bool removeTaintedBlockInst(const ExtendedValue& fact,
                                     const llvm::Instruction* currentInst);
  static bool isAutoGENInTaintedBlock(const llvm::Instruction* currentInst);

  static bool isMemoryLocationFact(const ExtendedValue& ev);
  static bool isKillAfterStoreFact(const ExtendedValue& ev);
  static void dumpMemoryLocation(const ExtendedValue& ev);
  static std::string getTypeName(const llvm::Type* type);

  static std::string getTraceFilename(std::string entryPoint);
};

} // namespace

#endif // DATAFLOWUTILS_H
