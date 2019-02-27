/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "LineNumberWriter.h"

namespace psr {

void
LineNumberWriter::write() const {

  std::ofstream writer(getOutFile());

  llvm::outs() << "Writing line number trace to: " << getOutFile() << "\n";

  for (const auto& statsEntry : getTraceStats().getStats()) {
    const auto traceStatModel = statsEntry.second;

    for (const auto& lineNumber : traceStatModel.getLineNumbers()) {
      writer << lineNumber << "\n";
    }
  }
}

} // namespace
