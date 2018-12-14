#include "MonoIntraPluginTest.h"

#include <algorithm>

#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Value.h>
#include <llvm/Support/raw_ostream.h>

namespace psr {

static std::unique_ptr<IntraMonoProblemPlugin>
makeIntraMonoProblemPlugin(LLVMBasedCFG& cfg,
                           const llvm::Function* f) {
  return std::unique_ptr<IntraMonoProblemPlugin>(new MonoIntraPluginTest(cfg, f));
}

__attribute__((constructor)) void init() {
  llvm::outs() << "init - MonoIntraPluginTest" << "\n";
  IntraMonoProblemPluginFactory["mono"] = &makeIntraMonoProblemPlugin;
}

__attribute__((destructor)) void finish() {
  llvm::outs() << "finish - MonoIntraPluginTest" << "\n";
}

static std::set<unsigned int> lineNumbers;

static bool
isValueInFacts(const MonoSet<const llvm::Value*> facts, const llvm::Value* value)
{
  for (const auto fact : facts) {
    if (fact == value) {
      llvm::outs() << "Found tainted value: " << value->getName() << "\n";
      return true;
    }
  }
  return false;
}

MonoSet<const llvm::Value*>
MonoIntraPluginTest::join(const MonoSet<const llvm::Value*> &oldFacts,
                          const MonoSet<const llvm::Value*> &newFacts) {
  llvm::outs() << "join()" << "\n";

  MonoSet<const llvm::Value*> res;
  std::set_union(oldFacts.begin(), oldFacts.end(), newFacts.begin(), newFacts.end(),
    std::inserter(res, res.begin()));

  for (auto v : res) {
    if (const auto instruction = llvm::dyn_cast<llvm::Instruction>(v)) {
      const llvm::DebugLoc loc = instruction->getDebugLoc();
      if (loc) {
        unsigned int line = loc.getLine();
        llvm::outs() << "Adding line: " << line << "\n";
        lineNumbers.insert(line);
      }
    }
  }
  return res;
}

bool
MonoIntraPluginTest::sqSubSetEqual(const MonoSet<const llvm::Value*> &newFacts,
                                   const MonoSet<const llvm::Value*> &oldFacts) {
  llvm::outs() << "sqSubSetEqual()" << "\n";

  llvm::outs() << "Old Facts: " << oldFacts.size() << "\n";
  llvm::outs() << "New Facts: " << newFacts.size() << "\n";

  //return std::includes(Rhs.begin(), Rhs.end(), Lhs.begin(), Lhs.end());
  /*
   * return false := join() + Add successors of dst
   * return true := next
   */
  return false;
}

MonoSet<const llvm::Value*>
MonoIntraPluginTest::flow(const llvm::Instruction* instruction,
                          const MonoSet<const llvm::Value*> &currentFacts) {

  llvm::outs() << "flow()" << "\n";
  llvm::outs() << "Function: " << instruction->getFunction()->getName() << ", Opcode: " << instruction->getOpcodeName() << "\n";
  llvm::outs() << "===========================" << "\n";

  MonoSet<const llvm::Value*> res = currentFacts;   // clone

  // Call Instruction
  if (const auto callInstruction = llvm::dyn_cast<llvm::CallInst>(instruction)) {
    llvm::outs() << "Got call instruction" << "\n";
    for (const auto &operand : callInstruction->operands()) {
      auto functionName = operand->getName();
      if (functionName.compare_lower("poison_pill") == 0) {
        llvm::outs() << "Adding call instruction fact" << "\n";
        res.insert(instruction);
      }
    }
  }
  // Binary Operator Instruction
  else if (const auto binaryOperator = llvm::dyn_cast<llvm::BinaryOperator>(instruction)) {
    llvm::outs() << "Got binary operator instruction" << "\n";

    // check if one of the operands contains a tainted value, if so push fact
    for (const auto &operand : binaryOperator->operands()) {
      bool isTainted = isValueInFacts(currentFacts, operand);
      if (isTainted) {
        llvm::outs() << "Adding binary operator instruction fact" << "\n";
        res.insert(binaryOperator);
        break;
      }
    }
  }
  // Load Instruction
  else if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(instruction)) {
    llvm::outs() << "Got load instruction" << "\n";

    // check if memory location is tainted, if so push fact
    const auto pointerOperand = loadInst->getPointerOperand();
    bool isTainted = isValueInFacts(currentFacts, pointerOperand);
    if (isTainted) {
      llvm::outs() << "Adding load instruction fact" << "\n";
      res.insert(loadInst);
    }
  }
  // Store Instruction
  else if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(instruction)) {
    llvm::outs() << "Got store instruction" << "\n";

    // check if value is tainted, if so push memory location
    const auto value = storeInst->getValueOperand();
    bool isTainted = isValueInFacts(currentFacts, value);
    if (isTainted) {
      const auto pointerOperand = storeInst->getPointerOperand();
      llvm::outs() << "Adding memory location: " << pointerOperand->getName() << "\n";
      res.insert(pointerOperand);
    }
  }

  if (res.empty()) {
    return currentFacts;
  }
  return res;
}

MonoMap<const llvm::Instruction*, MonoSet<const llvm::Value*>>
MonoIntraPluginTest::initialSeeds() {
  llvm::outs() << "initialSeeds()" << "\n";
  return {};
}

void
MonoIntraPluginTest::printReport() {
  llvm::outs() << "printReport()" << "\n";
  for (const auto lineNumber : lineNumbers) {
    llvm::outs() << lineNumber << "\n";
  }
}

} // namespace
