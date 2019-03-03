/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#include "LineNumberWriter.h"

namespace psr {

void
LineNumberWriter::write() const {

  std::ofstream writer(getOutFile());

  llvm::outs() << "Writing line number trace to: " << getOutFile() << "\n";

  for (const auto& fileEntry : getTraceStats().getStats()) {
    const auto functionStats = fileEntry.second;

    for (const auto& functionEntry : functionStats) {
      const auto lineNumberStats = functionEntry.second;

      for (const auto& lineNumberEntry : lineNumberStats) {
        writer << lineNumberEntry.getLineNumber() << "\n";
      }
    }
  }
}

} // namespace
