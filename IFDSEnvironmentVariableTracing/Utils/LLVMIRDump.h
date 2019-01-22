/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef LLVMIRDUMP_H
#define LLVMIRDUMP_H

#include <llvm/IR/Module.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/IRBuilder.h>

namespace psr {

class LLVMIRDump {
public:
  LLVMIRDump();
  ~LLVMIRDump() = default;

  const llvm::Value* getIntegerPtr(unsigned int value);

private:
  std::unique_ptr<llvm::LLVMContext> llvmContext;
  std::unique_ptr<const llvm::Module> llvmModule;
  std::unique_ptr<const llvm::IRBuilder<>> irBuilder;
};

} // namespace
#endif // LLVMIRDUMP_H
