/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#include "GenerateFlowFunction.h"

namespace psr {

std::set<ExtendedValue>
GenerateFlowFunction::computeTargetsExt(ExtendedValue& fact) {

  lineNumberStore.addLineNumber(currentInst);

  if (fact == zeroValue) return { ExtendedValue(currentInst) };

  return { fact };
}

} // namespace
