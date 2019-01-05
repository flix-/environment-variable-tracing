#include "LineNumberStore.h"

namespace psr {

LineNumberStore::LineNumberStore() {}

long
LineNumberStore::addLineNumber(const llvm::Instruction* instruction) {
  const llvm::DebugLoc debugLoc = instruction->getDebugLoc();
  if (debugLoc) {
    unsigned int lineNumber = debugLoc.getLine();
    this->lineNumbers.insert(lineNumber);
    return lineNumber;
  }
  return -1;
}

long
LineNumberStore::removeLineNumber(const llvm::Instruction* instruction) {
  const llvm::DebugLoc debugLoc = instruction->getDebugLoc();
  if (debugLoc) {
    unsigned int lineNumber = debugLoc.getLine();
    this->lineNumbers.erase(lineNumber);
    return lineNumber;
  }
  return -1;
}

std::set<unsigned int>
LineNumberStore::getLineNumbers(void) {
  return this->lineNumbers;
}

} // namespace
