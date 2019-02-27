/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef TRACESTATSWRITER_H
#define TRACESTATSWRITER_H

#include "TraceStats.h"

#include <fstream>
#include <string>

#include <llvm/Support/raw_ostream.h>

namespace psr {

class TraceStatsWriter {
public:
  TraceStatsWriter(const TraceStats& _traceStats,
                   const std::string _outFile)
    : traceStats(_traceStats),
      outFile(_outFile) { }
  virtual ~TraceStatsWriter() = default;

  virtual void write() const = 0;

protected:
  const TraceStats& getTraceStats() const { return traceStats; }
  const std::string getOutFile() const { return outFile; }

private:
  const TraceStats& traceStats;
  const std::string outFile;
};

} // namespace

#endif // TRACESTATSWRITER_H
