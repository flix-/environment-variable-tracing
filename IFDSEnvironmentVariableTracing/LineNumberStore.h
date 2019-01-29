/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef LINENUMBERSTORE_H
#define LINENUMBERSTORE_H

#include <set>
#include <string>

#include <llvm/IR/Instruction.h>

namespace psr {

class LineNumberStore {
public:
  LineNumberStore();

  long addLineNumber(const llvm::Instruction* instruction);
  std::set<std::string> getLineNumbers(void);

private:
  std::set<std::string> lineNumbers;
};

} // namespace
#endif // LINENUMBERSTORE_H
