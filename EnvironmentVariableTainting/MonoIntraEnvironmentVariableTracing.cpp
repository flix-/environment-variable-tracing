#include "MonoIntraEnvironmentVariableTracing.h"

#include "DataFlowFacts.h"
#include "DataFlowUtils.h"

#include <algorithm>
#include <fstream>

#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/CFG.h>
#include <llvm/Support/raw_ostream.h>

#include <phasar/Utils/LLVMShorthands.h>


namespace psr {

static const char* LINE_NUMBERS_OUTPUT_FILE = "line-numbers.txt";
static const char* TAINT_CALL = "getenv";

static std::set<unsigned int> lineNumbers;


static std::unique_ptr<IntraMonoProblemPlugin>
makeIntraMonoProblemPlugin(LLVMBasedCFG& cfg, const llvm::Function* f) {
  return std::unique_ptr<IntraMonoProblemPlugin>(new MonoIntraEnvironmentVariableTracing(cfg, f));
}

__attribute__((constructor)) void init() {
  llvm::outs() << "init - MonoIntraEnvironmentVariableTracing" << "\n";
  IntraMonoProblemPluginFactory["mono"] = &makeIntraMonoProblemPlugin;
}

__attribute__((destructor)) void finish() {
  llvm::outs() << "finish - MonoIntraEnvironmentVariableTracing" << "\n";
}

MonoSet<const llvm::Value*>
MonoIntraEnvironmentVariableTracing::join(const MonoSet<const llvm::Value*>& oldFacts, const MonoSet<const llvm::Value*>& newFacts) {

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
MonoIntraEnvironmentVariableTracing::sqSubSetEqual(const MonoSet<const llvm::Value*>& newFacts, const MonoSet<const llvm::Value*>& oldFacts) {
  /*
   * join() + add successors of dst if we got additional new facts from predecessor
   */
  bool isNewFactsSubsetOfOldFacts = std::includes(oldFacts.begin(), oldFacts.end(), newFacts.begin(), newFacts.end());

  //DataFlowUtils::dumpFacts(newFacts);

  return isNewFactsSubsetOfOldFacts;
}

MonoSet<const llvm::Value*>
MonoIntraEnvironmentVariableTracing::flow(const llvm::Instruction* instruction, const MonoSet<const llvm::Value*> &currentFacts) {

  llvm::outs() << "\n"; instruction->print(llvm::outs()); llvm::outs() << "\n";

  MonoSet<const llvm::Value*> newFacts = currentFacts;   // clone

  bool isCheckOperandsInst = llvm::isa<llvm::UnaryInstruction>(instruction) ||
                             llvm::isa<llvm::BinaryOperator>(instruction) ||
                             llvm::isa<llvm::CmpInst>(instruction) ||
                             llvm::isa<llvm::SelectInst>(instruction);

  /*
   * Every statement within a conditional branch whose condition is a tainted
   * value is also tainted. We push the first branch instruction satisfying
   * the condition to facts and remove it when leaving the branch. In between
   * every statement is pushed to facts. We need to make sure that no other
   * branch instruction is also tainted (nested branches). Same logic applies
   * for switch statements.
   *
   * char *tainted = getenv("gude");
   * char *a;
   *
   * if (a) {
   *    if (a) {
   *      do {
   *        a = tainted;
   *      } while (tainted);
   *    }
   *    int c = 2;
   * } else {
   *    ...
   * }
   * char *also_tainted = a;
   */
  const auto taintedBlock = DataFlowFacts::findBranchOrSwitchInstInFacts(newFacts);
  if (taintedBlock) {
    bool removeBranchOrSwitchInst = DataFlowUtils::isEndOfBranchOrSwitchInst(taintedBlock, instruction);
    if (removeBranchOrSwitchInst) {
      newFacts.erase(taintedBlock);
    } else {
      /*
       * Push every instruction to facts except branch or switch
       */
      bool isBranchOrSwitchInst = llvm::isa<llvm::BranchInst>(instruction) ||
                                  llvm::isa<llvm::SwitchInst>(instruction);
      if (!isBranchOrSwitchInst) {
        newFacts.insert(instruction);
      }
      return newFacts;
    }
  }

  /*
   * Check instructions for tainted values
   */

  // Call instruction
  if (const auto callInst = llvm::dyn_cast<llvm::CallInst>(instruction)) {
    llvm::outs() << "Got call instruction" << "\n";

    for (const auto &use : callInst->operands()) {
      auto functionName = use->getName();
      bool isTaintedCall = functionName.compare_lower(TAINT_CALL) == 0;
      if (isTaintedCall) {
        llvm::outs() << "Adding call instruction fact" << "\n";
        newFacts.insert(callInst);
        return newFacts;
      }
    }
  }
  // Load instruction
  else if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(instruction)) {
    llvm::outs() << "Got load instruction" << "\n";

    const auto memLocation = loadInst->getPointerOperand();
    bool isMemLocationTainted = DataFlowFacts::isExactMemoryLocationTainted(newFacts, memLocation);

    /*
     * memLocationTainted |
     *        0           | -
     *        1           | GEN
     */
    if (isMemLocationTainted) {
      llvm::outs() << "Adding load instruction fact" << "\n";
      newFacts.insert(loadInst);
      return newFacts;
    }
  }
  // Store instruction
  else if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(instruction)) {
    llvm::outs() << "Got store instruction" << "\n";

    const auto memLocation = storeInst->getPointerOperand();

    const auto value = storeInst->getValueOperand();
    bool isMemLocationTainted = DataFlowFacts::isExactMemoryLocationTainted(newFacts, memLocation);
    bool isValueTainted = DataFlowFacts::isValueInFacts(newFacts, value);

    /*
     * memLocationTainted | valueTainted |
     *        0           |      0       |  -
     *        0           |      1       |  GEN
     *        1           |      0       |  KILL
     *        1           |      1       |  KILL/GEN
     */
    // KILL
    if (isMemLocationTainted) {
      llvm::outs() << "Removing store instruction" << "\n";
      DataFlowFacts::removeExactMemoryLocation(newFacts, memLocation);
    }
    // GEN
    if (isValueTainted) {
      llvm::outs() << "Adding store instruction" << "\n";
      newFacts.insert(storeInst);
    }
    return newFacts;
  }
  // Phi node instruction
  else if (const auto phiNodeInst = llvm::dyn_cast<llvm::PHINode>(instruction)) {
    llvm::outs() << "Got phi node instruction" << "\n";

    const auto trueConstant = llvm::ConstantInt::getTrue(phiNodeInst->getContext());
    const auto falseConstant = llvm::ConstantInt::getFalse(phiNodeInst->getContext());

    // If phi node contains at least one tainted value push fact
    for (const auto &block : phiNodeInst->blocks()) {
      const auto &incomingValue = phiNodeInst->getIncomingValueForBlock(block);
      /*
       * We need special treatment if the value v of the <v, bb> pairs is not an
       * instruction but a constant (true / false). This is necessary to correctly
       * implement the boolean operators && and ||. E.g. the phi node of an || operation
       * looks as follows:
       *
       * %1 = phi i1 [ true, %entry ], [ %tobool2, %lor.rhs ]
       *
       * If the left hand side of the || operation has been a tainted value we cannot identify
       * this fact based on the phi node itself...
       *
       * Whenever we encounter true or false in a <v, bb> pair of a phi node we are backtracking
       * to the basic block and check the branch instruction for a tainted value.
       */
      if (const auto constant = llvm::dyn_cast<llvm::Constant>(incomingValue)) {
        if (constant == trueConstant || constant == falseConstant) {
          const auto &terminatorInst = block->getTerminator();

          for (const auto &use : terminatorInst->operands()) {
            bool isTainted = DataFlowFacts::isValueInFacts(newFacts, use.get());
            if (isTainted) {
              llvm::outs() << "Adding phi node instruction fact (constant)" << "\n";
              newFacts.insert(phiNodeInst);
              return newFacts;
            }
          }
        }
      }
      /*
       * If it's not a constant check whether value is tainted...
       */
      else {
        bool isTainted = DataFlowFacts::isValueInFacts(newFacts, incomingValue);
        if (isTainted) {
          llvm::outs() << "Adding phi node instruction fact" << "\n";
          newFacts.insert(phiNodeInst);
          return newFacts;
        }
      }
    }
  }
  // Branch instruction
  /*
   * Push branch instruction with tainted condition (see above). Note that as long
   * as there is a branch instruction in facts set we never reach code here.
   */
  else if(const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(instruction)) {
    llvm::outs() << "Got branch instruction" << "\n";

    bool isConditional = branchInst->isConditional();

    if (isConditional) {
      const auto &condition = branchInst->getCondition();

      bool isTainted = DataFlowFacts::isValueInFacts(newFacts, condition);
      if (isTainted) {
        llvm::outs() << "Adding conditional branch instruction fact" << "\n";
        newFacts.insert(branchInst);
        return newFacts;
      }
    }
  }
  // Switch instruction
  else if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(instruction)) {
    llvm::outs() << "Got switch instruction" << "\n";

    const auto &condition = switchInst->getCondition();
    bool isTainted = DataFlowFacts::isValueInFacts(newFacts, condition);
    if (isTainted) {
      llvm::outs() << "Adding switch instruction fact" << "\n";
      newFacts.insert(switchInst);
      return newFacts;
    }
  }
  // Operand checking instruction
  else if (isCheckOperandsInst) {
    llvm::outs() << "Got operands checking instruction (" << instruction->getOpcodeName() << ")" << "\n";

    for (const auto &use : instruction->operands()) {
      bool isTainted = DataFlowFacts::isValueInFacts(newFacts, use.get());
      if (isTainted) {
        llvm::outs() << "Adding fact" << "\n";
        newFacts.insert(instruction);
        return newFacts;
      }
    }
  }

  return newFacts;
}

MonoMap<const llvm::Instruction*, MonoSet<const llvm::Value*>>
MonoIntraEnvironmentVariableTracing::initialSeeds() {
  // This function is never called by Phasar
  return {};
}

void
MonoIntraEnvironmentVariableTracing::printReport() {
  std::ofstream writer(LINE_NUMBERS_OUTPUT_FILE);
  for (const auto lineNumber : lineNumbers) {
    writer << lineNumber << "\n";
  }
}

} // namespace
