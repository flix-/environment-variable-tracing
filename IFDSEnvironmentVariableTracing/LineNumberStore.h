/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef LINENUMBERSTORE_H
#define LINENUMBERSTORE_H

#include <map>
#include <set>
#include <string>

#include <llvm/IR/Instruction.h>

namespace psr {

class LineNumberStore {
public:
  LineNumberStore();

  long addLineNumber(const llvm::Instruction* instruction);
  const std::map<std::string, std::set<unsigned int>> getLineNumbers(void) const;

private:
  std::map<std::string, std::set<unsigned int>> lineNumbers;

  std::set<unsigned int>& getSetForKey(std::string key);
};

} // namespace
#endif // LINENUMBERSTORE_H
