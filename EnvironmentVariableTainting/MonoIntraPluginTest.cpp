#include "MonoIntraPluginTest.h"

#include <algorithm>
#include <fstream>

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

static const char* LINE_NUMBERS_OUTPUT_FILE = "line-numbers.txt";
static const char* TAINT_CALL = "getenv";

static std::set<unsigned int> lineNumbers;

static bool
isValueInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::Value* value)
{
  return facts.count(value);
}

MonoSet<const llvm::Value*>
MonoIntraPluginTest::join(const MonoSet<const llvm::Value*>& oldFacts,
                          const MonoSet<const llvm::Value*>& newFacts) {
  llvm::outs() << "join()" << "\n";

  MonoSet<const llvm::Value*> res;
  std::set_union(oldFacts.begin(), oldFacts.end(), newFacts.begin(), newFacts.end(),
    std::inserter(res, res.begin()));

  for (const auto v : res) {
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
MonoIntraPluginTest::sqSubSetEqual(const MonoSet<const llvm::Value*>& newFacts,
                                   const MonoSet<const llvm::Value*>& oldFacts) {
  llvm::outs() << "sqSubSetEqual()" << "\n";

  llvm::outs() << "Old Facts: " << oldFacts.size() << "\n";
  llvm::outs() << "New Facts: " << newFacts.size() << "\n";

  /*
   * join() + add successors of dst if we got additional new facts from predecessor
   */
  bool isNewFactsSubsetOfOldFacts = std::includes(oldFacts.begin(), oldFacts.end(), newFacts.begin(), newFacts.end());
  llvm::outs() << "isNewFactsSubsetOfOldFacts: " << isNewFactsSubsetOfOldFacts << "\n";

  return isNewFactsSubsetOfOldFacts;
}

MonoSet<const llvm::Value*>
MonoIntraPluginTest::flow(const llvm::Instruction* instruction,
                          const MonoSet<const llvm::Value*> &currentFacts) {

  llvm::outs() << "flow()" << "\n";
  llvm::outs() << "Function: " << instruction->getFunction()->getName() << ", Opcode: " << instruction->getOpcodeName() << "\n";
  llvm::outs() << "===========================" << "\n";

  MonoSet<const llvm::Value*> res = currentFacts;   // clone

  // Call Instruction
  if (const auto callInst = llvm::dyn_cast<llvm::CallInst>(instruction)) {
    llvm::outs() << "Got call instruction" << "\n";

    for (const auto &operand : callInst->operands()) {
      auto functionName = operand->getName();
      if (functionName.compare(TAINT_CALL) == 0) {
        llvm::outs() << "Adding call instruction fact" << "\n";
        res.insert(instruction);
      }
    }
  }
  // Binary Operator Instruction
  else if (const auto binaryOpInst = llvm::dyn_cast<llvm::BinaryOperator>(instruction)) {
    llvm::outs() << "Got binary operator instruction" << "\n";

    // check if one of the operands contains a tainted value, if so push fact
    for (const auto &operand : binaryOpInst->operands()) {
      bool isTainted = isValueInFacts(currentFacts, operand);
      if (isTainted) {
        llvm::outs() << "Adding binary operator instruction fact" << "\n";
        res.insert(binaryOpInst);
        break;
      }
    }
  }
  // Load Instruction
  else if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(instruction)) {
    llvm::outs() << "Got load instruction" << "\n";

    const auto memLocation = loadInst->getPointerOperand();
    bool isMemLocationTainted = isValueInFacts(currentFacts, memLocation);

    /*
     * memLocationTainted |
     *        0           | -
     *        1           | GEN
     */
    if (isMemLocationTainted) {
      llvm::outs() << "Adding load instruction fact" << "\n";
      res.insert(loadInst);
    }
  }
  // Store Instruction
  else if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(instruction)) {
    llvm::outs() << "Got store instruction" << "\n";

    const auto memLocation = storeInst->getPointerOperand();
    const auto value = storeInst->getValueOperand();
    bool isMemLocationTainted = isValueInFacts(currentFacts, memLocation);
    bool isValueTainted = isValueInFacts(currentFacts, value);

    /*
     * memLocationTainted | valueTainted |
     *        0           |      0       |  -
     *        0           |      1       |  GEN
     *        1           |      0       |  KILL
     *        1           |      1       |  -
     */
    if (!isMemLocationTainted && isValueTainted) {
      llvm::outs() << "Adding memory location: " << memLocation->getName() << "\n";
      res.insert(memLocation);
    }
    else if (isMemLocationTainted && !isValueTainted) {
      llvm::outs() << "Removing memory location: " << memLocation->getName() << "\n";
      res.erase(memLocation);
    }
  }
  // Phi node instruction
  else if (const auto phiNodeInst = llvm::dyn_cast<llvm::PHINode>(instruction)) {
    llvm::outs() << "Got phi node instruction" << "\n";

    // if phi node contains at least one tainted value push fact
    for (const auto &value : phiNodeInst->incoming_values()) {
      if (isValueInFacts(currentFacts, value)) {
        llvm::outs() << "Adding phi node instruction fact" << "\n";
        res.insert(phiNodeInst);
      }
    }
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

  std::ofstream writer(LINE_NUMBERS_OUTPUT_FILE);
  for (const auto lineNumber : lineNumbers) {
    writer << lineNumber << "\n";
  }
}

} // namespace
