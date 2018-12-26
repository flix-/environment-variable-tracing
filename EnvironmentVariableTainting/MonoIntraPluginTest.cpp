#include "MonoIntraPluginTest.h"

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

static std::unique_ptr<IntraMonoProblemPlugin>
makeIntraMonoProblemPlugin(LLVMBasedCFG& cfg, const llvm::Function* f) {
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

static void dumpFacts(const MonoSet<const llvm::Value*>& facts) {
  llvm::outs() << "Dumping facts" << "\n";
  llvm::outs() << "=============" << "\n";
  for (const auto fact : facts) {
    fact->print(llvm::outs()); llvm::outs() << "\n";
  }
  llvm::outs() << "=============" << "\n";
}

static bool
isEndOfTaintedBranch(const llvm::BranchInst *branchInst, const llvm::Instruction *instruction) {
  if (branchInst == nullptr) return false;
  if (instruction == nullptr) return false;

  const auto bbInst = instruction->getParent();
  if (bbInst == nullptr) return false;

  const auto bbLabel1 = branchInst->getOperand(1)->getName().contains_lower("end") ?
        branchInst->getOperand(1) :
        nullptr;
  const auto bbLabel2 = branchInst->getOperand(2)->getName().contains_lower("end") ?
        branchInst->getOperand(2) :
        nullptr;

  if (bbLabel1 && bbLabel1->getName().equals_lower(bbInst->getName())) return true;
  if (bbLabel2 && bbLabel2->getName().equals_lower(bbInst->getName())) return true;

  return false;
}

static bool
isEndOfTaintedSwitch(const llvm::SwitchInst* const switchInst, const llvm::Instruction *instruction) {
  const auto bbInst = instruction->getParent();
  if (bbInst == nullptr) return false;

  const auto instructionLabel = bbInst->getName();
  bool isEndOfSwitch = instructionLabel.contains_lower("epilog");
  if (!isEndOfSwitch) return false;

  /*
   * We now have an instruction that belongs to the end of a switch
   * statement. We need to figure out if the label matches the one
   * of the switch statement (e.g. we don't want to remove the switch
   * statement if it is a nested one). If the switch statement has a
   * default case we can obtain the label immediately if not we check
   * the labels of every successor of the default case.
   */
  const auto defaultBB = switchInst->getDefaultDest();
  const auto defaultLabel = defaultBB->getName();
  bool hasDefaultCase = defaultLabel.contains_lower("epilog");
  if (hasDefaultCase) {
    return instructionLabel.compare_lower(defaultLabel) == 0;
  } else {
    for (const auto succ : defaultBB->getTerminator()->successors()) {
      const auto defaultSuccessorLabel = succ->getName();
      if (instructionLabel.compare_lower(defaultSuccessorLabel) == 0) return true;
    }
  }
  return false;
}

static bool
isEndOfBranchOrSwitchInst(const llvm::Value *branchOrSwitchInst, const llvm::Instruction *instruction) {
  if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(branchOrSwitchInst)) {
    return isEndOfTaintedBranch(branchInst, instruction);
  }
  else if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(branchOrSwitchInst)) {
    return isEndOfTaintedSwitch(switchInst, instruction);
  }
  return false;
}

static bool
isGEPInstEqual(const llvm::GetElementPtrInst* gepInst, const llvm::GetElementPtrInst* gepFact) {
  if (gepInst->getNumOperands() != gepFact->getNumOperands()) return false;

  for (unsigned int i = 0; i < gepInst->getNumOperands(); i++) {
    const auto *gepInstOperand = gepInst->getOperand(i);
    const auto *gepFactOperand = gepFact->getOperand(i);

    /*
     * Compare the first operand (ptr) by type if it is another GEP instruction.
     * This is necessary for nested structs as another GEP instructions cannot
     * be compared via object reference.
     */
    bool isInstOperandGepPtr = llvm::isa<llvm::GetElementPtrInst>(gepInstOperand);
    bool isFactOperandGepPtr = llvm::isa<llvm::GetElementPtrInst>(gepFactOperand);
    if (isInstOperandGepPtr != isFactOperandGepPtr) return false;

    if (isInstOperandGepPtr && isFactOperandGepPtr) {
      const auto gepInstOperandType = gepInstOperand->getType();
      const auto gepFactOperandType = gepFactOperand->getType();
      if (gepInstOperandType != gepFactOperandType) {
        return false;
      }
      continue;
    }

    /*
     * Compare everything else via object reference (alloca / indices)
     */
    if (gepInstOperand != gepFactOperand) {
      return false;
    }
  }
  return true;
}

static bool
isGEPInstInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::GetElementPtrInst* gepInst) {
  for (const auto &fact : facts) {
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      if (const auto gepFact = llvm::dyn_cast<llvm::GetElementPtrInst>(storeFact->getPointerOperand())) {
        const llvm::GetElementPtrInst* gepInstPtr = gepInst;
        const llvm::GetElementPtrInst* gepFactPtr = gepFact;
        do {
          bool isEqual = isGEPInstEqual(gepInstPtr, gepFactPtr);
          if (!isEqual) break;

          // if operand pointer was alloca instruction we are done
          bool isFinal = llvm::isa<llvm::AllocaInst>(gepInstPtr->getPointerOperand());
          if (isFinal) return true;

          // continue with inner GEP
          gepInstPtr = llvm::cast<llvm::GetElementPtrInst>(gepInstPtr->getPointerOperand());
          gepFactPtr = llvm::cast<llvm::GetElementPtrInst>(gepFactPtr->getPointerOperand());
        } while (true);
      }
    }
  }
  return false;
}

static void
removeGEPMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::GetElementPtrInst* gepInst) {
  for (auto it = facts.begin(); it != facts.end(); ) {
    const auto fact = *it;
    bool isIteratorIncremented = false;

    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      if (const auto gepFact = llvm::dyn_cast<llvm::GetElementPtrInst>(storeFact->getPointerOperand())) {
        const llvm::GetElementPtrInst* gepInstPtr = gepInst;
        const llvm::GetElementPtrInst* gepFactPtr = gepFact;
        do {
          bool isEqual = isGEPInstEqual(gepInstPtr, gepFactPtr);
          if (!isEqual) break;

          // If operand pointer was alloca instruction we are done
          bool isFinal = llvm::isa<llvm::AllocaInst>(gepInstPtr->getPointerOperand());
          if (isFinal) {
            it = facts.erase(it);
            isIteratorIncremented = true;
            break;
          }

          // Continue with inner GEP
          gepInstPtr = llvm::cast<llvm::GetElementPtrInst>(gepInstPtr->getPointerOperand());
          gepFactPtr = llvm::cast<llvm::GetElementPtrInst>(gepFactPtr->getPointerOperand());
        } while (true);
      }
    }
    if (!isIteratorIncremented) ++it;
  }
}

static bool
isAllocaInstInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::AllocaInst* allocaInst) {
  for (const auto fact : facts) {
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      if (const auto allocaFact = llvm::dyn_cast<llvm::AllocaInst>(storeFact->getPointerOperand())) {
        bool isEqual = allocaFact == allocaInst;
        if (isEqual) return true;
      }
    }
  }
  return false;
}

static void
removeAllocaMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::AllocaInst* allocaInst) {
  for (auto it = facts.begin(); it != facts.end(); ) {
    const auto fact = *it;
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      if (const auto allocaFact = llvm::dyn_cast<llvm::AllocaInst>(storeFact->getPointerOperand())) {
        bool isEqual = allocaFact == allocaInst;
        if (isEqual) {
          it = facts.erase(it);
          /*
           * There can be more than one store statement pointing to the same alloca so we need to
           * delete all of them. Example:
           *
           * int a;
           * switch (x) {
           * case 0:
           *    a = 1;
           *    break;
           * case 1:
           *    a = 2;
           *    break;
           * default:
           *    a = 3;
           * }
           */
          continue;
        }
      }
    }
    ++it;
  }
}

static const llvm::Value*
findBranchOrSwitchInstInFacts(const MonoSet<const llvm::Value*>& facts) {
  for (const auto fact : facts) {
    bool isBranchInst = llvm::isa<llvm::BranchInst>(fact);
    bool isSwitchInst = llvm::isa<llvm::SwitchInst>(fact);
    if (isBranchInst || isSwitchInst) return fact;
  }
  return nullptr;
}

static bool
isValueInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::Value* value) {
  /*
   * If we get an alloca instruction e.g. from a load instruction we need to check
   * every tainted store instruction for that address.
   */
  if (const auto allocaInst = llvm::dyn_cast<llvm::AllocaInst>(value)) {
    return isAllocaInstInFacts(facts, allocaInst);
  }
  /*
   * We cannot compare a GEP instruction via object reference as for every load a new
   * instance will be created. Although it possibly holds the same address as a GEP instruction
   * already part of the set of facts comparison via pointer yields wrong results. Apply own
   * equality logic supporting nested GEP's. As with alloca instructions we need to search
   * all store instructions.
   */
  if (const auto gepInst = llvm::dyn_cast<llvm::GetElementPtrInst>(value)) {
    return isGEPInstInFacts(facts, gepInst);
  }
  /*
   * Compare via object reference
   */
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

  //dumpFacts(newFacts);

  return isNewFactsSubsetOfOldFacts;
}

MonoSet<const llvm::Value*>
MonoIntraPluginTest::flow(const llvm::Instruction* instruction,
                          const MonoSet<const llvm::Value*> &currentFacts) {

  llvm::outs() << "\n" << "flow()" << "\n";
  instruction->print(llvm::outs()); llvm::outs() << "\n";
  llvm::outs() << "===========================" << "\n";

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
  const auto taintedBlock = findBranchOrSwitchInstInFacts(newFacts);
  if (taintedBlock) {
    bool removeBranchOrSwitchInst = isEndOfBranchOrSwitchInst(taintedBlock, instruction);
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
  // Operand checking instruction
  else if (isCheckOperandsInst) {
    llvm::outs() << "Got operands checking instruction (" << instruction->getOpcodeName() << ")" << "\n";

    for (const auto &use : instruction->operands()) {
      bool isTainted = isValueInFacts(newFacts, use.get());
      if (isTainted) {
        llvm::outs() << "Adding fact" << "\n";
        newFacts.insert(instruction);
        return newFacts;
      }
    }
  }
  // Load instruction
  else if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(instruction)) {
    llvm::outs() << "Got load instruction" << "\n";

    const auto memLocation = loadInst->getPointerOperand();
    bool isMemLocationTainted = isValueInFacts(newFacts, memLocation);

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
    bool isMemLocationTainted = isValueInFacts(newFacts, memLocation);
    bool isValueTainted = isValueInFacts(newFacts, value);

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
      /*
       * If memory location is a GEP instruction we cannot use erase on the set instance
       * as this works based on object references. Instead we have to iterate all facts
       * and remove the GEP instruction that is pointing to the store instruction's
       * memory location.
       */
      if (const auto gepMemLocation = llvm::dyn_cast<llvm::GetElementPtrInst>(memLocation)) {
        removeGEPMemoryLocation(newFacts, gepMemLocation);
      }
      /*
       * If memory location is alloca instruction we need to find the corresponding store
       * instruction in the facts set.
       */
      else if (const auto allocaMemLocation = llvm::dyn_cast<llvm::AllocaInst>(memLocation)) {
        removeAllocaMemoryLocation(newFacts, allocaMemLocation);
      }
      else {
        newFacts.erase(memLocation);
      }
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
            bool isTainted = isValueInFacts(newFacts, use.get());
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
        bool isTainted = isValueInFacts(newFacts, incomingValue);
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
      // Filter branch instructions
      bool isIfBranch = branchInst->getOperand(1)->getName().contains_lower("if.");
      bool isForBranch = branchInst->getOperand(1)->getName().contains_lower("for.");
      bool isWhileBranch = branchInst->getOperand(1)->getName().contains_lower("while.");
      bool isDoBranch = branchInst->getOperand(1)->getName().contains_lower("do.");
      if (isIfBranch || isForBranch || isWhileBranch || isDoBranch) {
        const auto &condition = branchInst->getCondition();

        bool isTainted = isValueInFacts(newFacts, condition);
        if (isTainted) {
          llvm::outs() << "Adding conditional branch instruction fact" << "\n";
          newFacts.insert(branchInst);
          return newFacts;
        }
      }
    }
  }
  // Switch instruction
  else if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(instruction)) {
    llvm::outs() << "Got switch instruction" << "\n";

    const auto &condition = switchInst->getCondition();
    bool isTainted = isValueInFacts(newFacts, condition);
    if (isTainted) {
      llvm::outs() << "Adding switch instruction fact" << "\n";
      newFacts.insert(switchInst);
      return newFacts;
    }
  }

  return newFacts;
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
