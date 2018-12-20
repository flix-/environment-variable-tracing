#include "MonoIntraPluginTest.h"

#include <algorithm>
#include <fstream>

#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/Constants.h>

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
isValueInTaintedBasicBlock(const MonoSet<const llvm::Value*>& facts, const llvm::Instruction *instruction) {
  if (instruction == nullptr) return false;

  /*
   * Do not add unconditional branch instructions as they would also
   * be used for basic block checking (and raise an exception as they
   * do not provide the expected amount of operands...)
   */
  if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(instruction)) {
    if (!branchInst->isConditional()) return false;
  }

  const auto bbInst = instruction->getParent();
  if (bbInst == nullptr) return false;

  for (const auto &fact : facts) {
    if(const auto condBrInst = llvm::dyn_cast<llvm::BranchInst>(fact)) {
      const auto bbThen = condBrInst->getOperand(2);
      const auto bbElse = condBrInst->getOperand(1)->getName().contains_lower("if.else") ?
            condBrInst->getOperand(1) :
            nullptr;

      if (bbThen->getName().equals_lower(bbInst->getName())) return true;
      if (bbElse && bbElse->getName().equals_lower(bbElse->getName())) return true;
    }
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
    if (const auto gepFact = llvm::dyn_cast<llvm::GetElementPtrInst>(fact)) {
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
  return false;
}

static void
removeGEPMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::GetElementPtrInst* gepInst) {
  for (auto fact : facts) {
    if (const auto gepFact = llvm::dyn_cast<llvm::GetElementPtrInst>(fact)) {
      const llvm::GetElementPtrInst* gepInstPtr = gepInst;
      const llvm::GetElementPtrInst* gepFactPtr = gepFact;
      do {
        bool isEqual = isGEPInstEqual(gepInstPtr, gepFactPtr);
        if (!isEqual) break;

        // If operand pointer was alloca instruction we are done
        bool isFinal = llvm::isa<llvm::AllocaInst>(gepInstPtr->getPointerOperand());
        if (isFinal) {
          facts.erase(fact);
          return;
        }

        // Continue with inner GEP
        gepInstPtr = llvm::cast<llvm::GetElementPtrInst>(gepInstPtr->getPointerOperand());
        gepFactPtr = llvm::cast<llvm::GetElementPtrInst>(gepFactPtr->getPointerOperand());
      } while (true);
    }
  }
}

static bool
isAllocaInstInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::AllocaInst* allocaInst) {
  for (const auto fact : facts) {
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      const auto memLocation = storeFact->getPointerOperand();
      bool isEqual = memLocation == allocaInst;
      if (isEqual) return true;
    }
  }
  return false;
}

static void
removeAllocaMemoryLocation(MonoSet<const llvm::Value*>& facts, const llvm::AllocaInst* allocaInst) {
  for (auto it = facts.begin(); it != facts.end(); ) {
    const auto fact = *it;
    if (const auto storeFact = llvm::dyn_cast<llvm::StoreInst>(fact)) {
      const auto memLocation = storeFact->getPointerOperand();
      bool isEqual = memLocation == allocaInst;
      if (isEqual) {
        it = facts.erase(it);
        break;
      }
    }
    ++it;
  }
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
   * equality logic supporting nested GEP's.
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
  llvm::outs() << "isNewFactsSubsetOfOldFacts: " << isNewFactsSubsetOfOldFacts << "\n";

  return isNewFactsSubsetOfOldFacts;
}

MonoSet<const llvm::Value*>
MonoIntraPluginTest::flow(const llvm::Instruction* instruction,
                          const MonoSet<const llvm::Value*> &currentFacts) {

  llvm::outs() << "flow()" << "\n";
  llvm::outs() << "Function: " << instruction->getFunction()->getName() << ", Opcode: " << instruction->getOpcodeName() << "\n";
  llvm::outs() << "===========================" << "\n";

  MonoSet<const llvm::Value*> newFacts = currentFacts;   // clone

  /*
   * Every statement within a basic block reachable by a branch instruction
   * that is dependent on a tainted value is also tainted. For example:
   *
   * char *tainted = getenv("gude");
   * char *a;
   *
   * if (tainted != NULL) {
   *    a = "hello world";
   * } else {
   *    ...
   * }
   * char *also_tainted = a;
   *
   * We push every conditional branch instruction that is dependent on an environment
   * variable to facts and then check for each instruction whether it is part of a
   * basic block mentioned in the tainted branch instruction.
   */
  bool isBBTainted = isValueInTaintedBasicBlock(newFacts, instruction);
  if (isBBTainted) {
    newFacts.insert(instruction);
  }
  // Call instruction
  else if (const auto callInst = llvm::dyn_cast<llvm::CallInst>(instruction)) {
    llvm::outs() << "Got call instruction" << "\n";

    for (const auto &use : callInst->operands()) {
      auto functionName = use->getName();
      if (functionName.compare(TAINT_CALL) == 0) {
        llvm::outs() << "Adding call instruction fact" << "\n";
        newFacts.insert(callInst);
        break;
      }
    }
  }
  // Binary operator instruction
  else if (const auto binaryOpInst = llvm::dyn_cast<llvm::BinaryOperator>(instruction)) {
    llvm::outs() << "Got binary operator instruction" << "\n";

    // Check if one of the operands contains a tainted value, if so push fact
    for (const auto &use : binaryOpInst->operands()) {
      bool isTainted = isValueInFacts(newFacts, use.get());
      if (isTainted) {
        llvm::outs() << "Adding binary operator instruction fact" << "\n";
        newFacts.insert(binaryOpInst);
        break;
      }
    }
  }
  // Compare instruction
  else if (const auto compareInst = llvm::dyn_cast<llvm::CmpInst>(instruction)) {
    llvm::outs() << "Got a compare instruction" << "\n";

    // Check if one of the operands contains a tainted value, if so push fact
    for (const auto &use : compareInst->operands()) {
      bool isTainted = isValueInFacts(newFacts, use.get());
      if (isTainted) {
        llvm::outs() << "Adding compare instruction fact" << "\n";
        newFacts.insert(compareInst);
        break;
      }
    }
  }
  // Zext instruction
  else if (const auto zextInst = llvm::dyn_cast<llvm::ZExtInst>(instruction)) {
    llvm::outs() << "Got a zextInst instruction" << "\n";

    // Check if one of the operands contains a tainted value, if so push fact
    for (const auto &use : zextInst->operands()) {
      bool isTainted = isValueInFacts(newFacts, use.get());
      if (isTainted) {
        llvm::outs() << "Adding zextInst instruction fact" << "\n";
        newFacts.insert(zextInst);
        break;
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
     *        1           |      1       |  -
     */
    if (!isMemLocationTainted && isValueTainted) {
      llvm::outs() << "Adding store instruction" << "\n";
      newFacts.insert(storeInst);
    }
    else if (isMemLocationTainted && !isValueTainted) {
      llvm::outs() << "Removing store instruction" << "\n";
      /*
       * If memory location is a GEP instruction we cannot use erase on the set instance
       * as this works based on object references. Instead we have to iterate all facts
       * and remove the GEP instruction that is pointing to the store instruction's
       * memory location.
       */
      if (const auto gepMemLocation = llvm::dyn_cast<llvm::GetElementPtrInst>(memLocation)) {
        //dumpFacts(newFacts);
        removeGEPMemoryLocation(newFacts, gepMemLocation);
        //dumpFacts(newFacts);
      }
      /*
       * If memory location is alloca instruction we need to find the corresponding store
       * instruction in the facts set.
       */
      else if (const auto allocaMemLocation = llvm::dyn_cast<llvm::AllocaInst>(memLocation)) {
        //dumpFacts(newFacts);
        removeAllocaMemoryLocation(newFacts, allocaMemLocation);
        //dumpFacts(newFacts);
      }
      else {
        newFacts.erase(memLocation);
      }
    }
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
              break;
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
          break;
        }
      }
    }
  }
  // Select instruction
  else if (const auto selectInst = llvm::dyn_cast<llvm::SelectInst>(instruction)) {
    llvm::outs() << "Got select instruction" << "\n";

    for (const auto &use : selectInst->operands()) {
      bool isTainted = isValueInFacts(newFacts, use.get());
      if (isTainted) {
        llvm::outs() << "Adding select instruction fact" << "\n";
        newFacts.insert(selectInst);
        break;
      }
    }
  }
  // Branch instruction
  /*
   * If we have a conditional branch instruction and the condition is a
   * tainted value then all branch destination basic blocks are also tainted.
   */
  else if(const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(instruction)) {
    llvm::outs() << "Got branch instruction" << "\n";

    bool isConditional = branchInst->isConditional();
    if (isConditional) {
      const auto &condition = branchInst->getCondition();

      bool isTainted = isValueInFacts(newFacts, condition);
      if (isTainted) {
        llvm::outs() << "Adding conditional branch instruction fact" << "\n";
        newFacts.insert(branchInst);
      }
    }
  }
  // Return instruction
  /*
   * Currently not necessary to push fact here as ret instruction doesn't have
   * a successor that can evaluate the fact... Maybe later needed in order to
   * figure out whether ret instruction is dependent on environment variable?!
   */
  /*
  else if (const auto returnInst = llvm::dyn_cast<llvm::ReturnInst>(instruction)) {
    const auto returnValue = returnInst->getReturnValue();
    if (returnValue) {
      bool isTainted = isValueInFacts(newFacts, returnValue);
      if (isTainted) {
        llvm::outs() << "Adding ret instruction fact" << "\n";
        newFacts.insert(returnInst);
      }
    }
  }
  */
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
