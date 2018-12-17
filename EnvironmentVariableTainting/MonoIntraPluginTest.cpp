#include "MonoIntraPluginTest.h"

#include <algorithm>
#include <fstream>

#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Value.h>
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
        gepInstPtr = llvm::dyn_cast<llvm::GetElementPtrInst>(gepInstPtr->getPointerOperand());
        gepFactPtr = llvm::dyn_cast<llvm::GetElementPtrInst>(gepFactPtr->getPointerOperand());
      } while (true);
    }
  }
  return false;
}

static bool
isValueInFacts(const MonoSet<const llvm::Value*>& facts, const llvm::Value* value) {
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
   * Compare via reference
   */
  return facts.count(value);
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

        // if operand pointer was alloca instruction we are done
        bool isFinal = llvm::isa<llvm::AllocaInst>(gepInstPtr->getPointerOperand());
        if (isFinal) {
          facts.erase(fact);
          return;
        }

        // continue with inner GEP
        gepInstPtr = llvm::dyn_cast<llvm::GetElementPtrInst>(gepInstPtr->getPointerOperand());
        gepFactPtr = llvm::dyn_cast<llvm::GetElementPtrInst>(gepFactPtr->getPointerOperand());
      } while (true);
    }
  }
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

  // Call Instruction
  if (const auto callInst = llvm::dyn_cast<llvm::CallInst>(instruction)) {
    llvm::outs() << "Got call instruction" << "\n";

    for (const auto &operand : callInst->operands()) {
      auto functionName = operand->getName();
      if (functionName.compare(TAINT_CALL) == 0) {
        llvm::outs() << "Adding call instruction fact" << "\n";
        newFacts.insert(instruction);
      }
    }
  }
  // Binary Operator Instruction
  else if (const auto binaryOpInst = llvm::dyn_cast<llvm::BinaryOperator>(instruction)) {
    llvm::outs() << "Got binary operator instruction" << "\n";

    // check if one of the operands contains a tainted value, if so push fact
    for (const auto &operand : binaryOpInst->operands()) {
      bool isTainted = isValueInFacts(newFacts, operand);
      if (isTainted) {
        llvm::outs() << "Adding binary operator instruction fact" << "\n";
        newFacts.insert(binaryOpInst);
        break;
      }
    }
  }
  // Load Instruction
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
  // Store Instruction
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
      llvm::outs() << "Adding memory location: " << memLocation->getName() << "\n";
      newFacts.insert(memLocation);
    }
    else if (isMemLocationTainted && !isValueTainted) {
      llvm::outs() << "Removing memory location: " << memLocation->getName() << "\n";
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
      } else {
        newFacts.erase(memLocation);
      }
    }
  }
  // Phi node instruction
  else if (const auto phiNodeInst = llvm::dyn_cast<llvm::PHINode>(instruction)) {
    llvm::outs() << "Got phi node instruction" << "\n";

    // if phi node contains at least one tainted value push fact
    for (const auto &value : phiNodeInst->incoming_values()) {
      if (isValueInFacts(newFacts, value)) {
        llvm::outs() << "Adding phi node instruction fact" << "\n";
        newFacts.insert(phiNodeInst);
      }
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
