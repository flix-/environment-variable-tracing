/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "LineNumberStore.h"

#include <llvm/IR/DebugInfoMetadata.h>

namespace psr {

LineNumberStore::LineNumberStore() {}

long
LineNumberStore::addLineNumber(const llvm::Instruction* instruction) {

  const llvm::DebugLoc debugLocInst = instruction->getDebugLoc();
  if (!debugLocInst) return 0;

  const llvm::DebugLoc debugLocFn = debugLocInst.getFnDebugLoc();
  if (!debugLocFn) return 0;

  const auto* fnScope = llvm::cast<llvm::DIScope>(debugLocFn.getScope());

  const std::string absolutePath = fnScope->getDirectory().str() +
                                   "/" +
                                   fnScope->getFilename().str();

  unsigned int lineNumber = debugLocInst->getLine();

  getSetForKey(absolutePath).insert(lineNumber);

  return 1;
}

std::set<unsigned int>&
LineNumberStore::getSetForKey(std::string key) {

  auto set = lineNumbers.find(key);
  if (set != lineNumbers.end()) return set->second;

  lineNumbers.insert({ key, std::set<unsigned int>() });

  return lineNumbers.find(key)->second;
}

const std::map<std::string, std::set<unsigned int>>
LineNumberStore::getLineNumbers(void) const {

  return lineNumbers;
}

} // namespace
