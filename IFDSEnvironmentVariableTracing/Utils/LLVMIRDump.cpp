#include "LLVMIRDump.h"

#include <llvm/IR/Module.h>

namespace psr {

LLVMIRDump::LLVMIRDump() {
  llvmContext = std::unique_ptr<llvm::LLVMContext>(new llvm::LLVMContext());
  llvmModule = std::unique_ptr<llvm::Module>(new llvm::Module("LLVMIRDump", *llvmContext));
  irBuilder = std::unique_ptr<llvm::IRBuilder<>>(new llvm::IRBuilder<>(*llvmContext));
}

const llvm::Value*
LLVMIRDump::getIntegerPtr(unsigned int value) {
  return llvm::ConstantInt::get(*llvmContext, llvm::APInt(32, value, false));
}

} // namespace
