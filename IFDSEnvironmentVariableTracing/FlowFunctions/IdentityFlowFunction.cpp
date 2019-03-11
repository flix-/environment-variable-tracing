/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  *                          <seroland86@gmail.com>
  */

#include "IdentityFlowFunction.h"

namespace psr {

std::set<ExtendedValue>
IdentityFlowFunction::computeTargetsExt(ExtendedValue& fact)
{
  return { fact };
}

} // namespace
