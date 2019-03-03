/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#include "TraceStats.h"

#include <llvm/IR/Function.h>
#include <llvm/IR/Instructions.h>

#include <llvm/IR/DebugInfoMetadata.h>

#include <llvm/Support/raw_ostream.h>

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

  const std::string file = fnScope->getDirectory().str() +
                           "/" +
                           fnScope->getFilename().str();

  unsigned int lineNumber = debugLocInst->getLine();

  TraceStats::LineNumberStats& lineNumberStats = getLineNumberStats(file, functionName);

  LineNumberEntry lineNumberEntry(lineNumber);

  bool isReturnValue = llvm::isa<llvm::ReturnInst>(instruction);
  if (isReturnValue) {
    // Make sure we do not have duplicate line numbers.
    lineNumberStats.erase(lineNumberEntry);

    lineNumberEntry.setReturnValue(true);
  }

  lineNumberStats.insert(lineNumberEntry);

  return 1;
}

TraceStats::FunctionStats&
TraceStats::getFunctionStats(std::string file) {

  auto functionStatsEntry = stats.find(file);
  if (functionStatsEntry != stats.end()) return functionStatsEntry->second;

  stats.insert({ file, FunctionStats() });

  return stats.find(file)->second;
}

TraceStats::LineNumberStats&
TraceStats::getLineNumberStats(std::string file, std::string function) {

  TraceStats::FunctionStats& functionStats = getFunctionStats(file);

  auto lineNumberEntry = functionStats.find(function);
  if (lineNumberEntry != functionStats.end()) return lineNumberEntry->second;

  functionStats.insert({ function, LineNumberStats() });

  return functionStats.find(function)->second;
}

} // namespace
