#ifndef LINENUMBERSTORE_H
#define LINENUMBERSTORE_H

#include <set>

#include <llvm/IR/Instruction.h>

namespace psr {

class LineNumberStore
{
public:
  LineNumberStore();

  long addLineNumber(const llvm::Instruction* instruction);
  long removeLineNumber(const llvm::Instruction* instruction);
  std::set<unsigned int> getLineNumbers(void);

private:
  std::set<unsigned int> lineNumbers;
};

} // namespace
#endif // LINENUMBERSTORE_H
