/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "LcovWriter.h"

namespace psr {

void
LcovWriter::write() const {

  std::ofstream writer(getOutFile());

  llvm::outs() << "Writing lcov trace to: " << getOutFile() << "\n";

  for (const auto& statsEntry : getTraceStats().getStats()) {
    const auto path = statsEntry.first;
    const auto traceStatModel = statsEntry.second;

    writer << "SF:" << path << "\n";

    for (const auto& function : traceStatModel.getFunctions()) {
      writer << "FNDA:" << "1," << function << "\n";
    }

    for (const auto& lineNumber : traceStatModel.getLineNumbers()) {
      writer << "DA:" << lineNumber << ",1" << "\n";
    }

    writer << "end_of_record" << "\n";
  }
}

} // namespace
