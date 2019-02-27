/**
  * @author Sebastian Roland <sebastianwolfgang.roland@stud.tu-darmstadt.de>
  */

#ifndef TRACESTATSMODEL_H
#define TRACESTATSMODEL_H

#include <set>
#include <string>

namespace psr {

class TraceStatsModel {
public:
  TraceStatsModel() { }
  ~TraceStatsModel() = default;

  const std::set<std::string> getFunctions() const { return functions; }
  void addFunction(std::string function) { functions.insert(function); }

  const std::set<unsigned int> getLineNumbers() const { return lineNumbers; }
  void addLineNumber(unsigned int lineNumber) { lineNumbers.insert(lineNumber); }

  void addFunctionAndLineNumber(std::string function,
                                unsigned int lineNumber) {
    addFunction(function);
    addLineNumber(lineNumber);
  }

private:
  std::set<std::string> functions;
  std::set<unsigned int> lineNumbers;
};

} // namespace

#endif // TRACESTATSMODEL_H
