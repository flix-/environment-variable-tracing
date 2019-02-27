/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "TraceStats.h"

#include <llvm/IR/Function.h>

#include <llvm/IR/DebugInfoMetadata.h>

namespace psr {

long
TraceStats::add(const llvm::Instruction* instruction) {

  const llvm::DebugLoc debugLocInst = instruction->getDebugLoc();
  if (!debugLocInst) return 0;

  const llvm::DebugLoc debugLocFn = debugLocInst.getFnDebugLoc();
  if (!debugLocFn) return 0;

  const auto function = instruction->getFunction();
  if (!function) return 0;

  const auto functionName = function->getName();

  const auto fnScope = llvm::cast<llvm::DIScope>(debugLocFn.getScope());

  const std::string absolutePath = fnScope->getDirectory().str() +
                                   "/" +
                                   fnScope->getFilename().str();

  unsigned int lineNumber = debugLocInst->getLine();

  getTraceStatsModelForPath(absolutePath).addFunctionAndLineNumber(functionName,
                                                                   lineNumber);

  return 1;
}

TraceStatsModel&
TraceStats::getTraceStatsModelForPath(std::string absolutePath) {

  auto statsEntry = stats.find(absolutePath);
  if (statsEntry != stats.end()) return statsEntry->second;

  stats.insert({ absolutePath, TraceStatsModel()} );

  return stats.find(absolutePath)->second;
}

} // namespace
