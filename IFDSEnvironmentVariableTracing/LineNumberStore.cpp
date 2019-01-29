/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "LineNumberStore.h"

#include <sstream>

#include <llvm/IR/DebugInfoMetadata.h>

namespace psr {

LineNumberStore::LineNumberStore() {}

long
LineNumberStore::addLineNumber(const llvm::Instruction* instruction) {

  const llvm::DebugLoc debugLocInst = instruction->getDebugLoc();
  if (!debugLocInst) return 0;
  const llvm::DebugLoc debugLocFn = debugLocInst.getFnDebugLoc();
  if (!debugLocFn) return 0;

  const auto *fnScope = llvm::cast<llvm::DIScope>(debugLocFn.getScope());

  std::stringstream stream;
  stream << fnScope->getDirectory().str() <<
            "/" <<
            fnScope->getFilename().str() <<
            ":" <<
            debugLocInst->getLine();

  const std::string logLine = stream.str();

  this->lineNumbers.insert(logLine);

  return 1;
}

std::set<std::string>
LineNumberStore::getLineNumbers(void) {
  return this->lineNumbers;
}

} // namespace
