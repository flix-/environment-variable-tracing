/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef TRACESTATS_H
#define TRACESTATS_H

#include "TraceStatsModel.h"

#include <map>

#include <llvm/IR/Instruction.h>

namespace psr {

class TraceStats {
public:
  TraceStats() { }
  ~TraceStats() = default;

  long add(const llvm::Instruction* instruction);
  const std::map<std::string, TraceStatsModel> getStats() const { return stats; }

private:
  std::map<std::string, TraceStatsModel> stats;

  TraceStatsModel& getTraceStatsModelForPath(std::string absolutePath);
};

} // namespace

#endif // TRACESTATS_H
