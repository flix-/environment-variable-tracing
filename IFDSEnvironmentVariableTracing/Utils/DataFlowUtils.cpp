#include "DataFlowUtils.h"

#include <queue>
#include <stack>
#include <string>

#include <llvm/IR/IntrinsicInst.h>

#include <llvm/Support/raw_ostream.h>

using namespace psr;

static const llvm::Value* POISON_PILL = reinterpret_cast<const llvm::Value*>("ALL I NEED IS A UNIQUE PTR");

static std::string
getTypeName(const llvm::Type* type) {

  std::string typeName;
  llvm::raw_string_ostream typeRawOutputStream(typeName);
  type->print(typeRawOutputStream);

  return typeRawOutputStream.str();
}

static bool
isUnionBitCast(const llvm::BitCastInst* bitCastInst) {

  std::string typeName = getTypeName(bitCastInst->getSrcTy());

  return typeName.find("union") != std::string::npos;
}

static bool
isGEPPartEqual(const llvm::GetElementPtrInst* memLocationFactGEP,
               const llvm::GetElementPtrInst* memLocationInstGEP) {

  bool hasSameNumOfOperands = memLocationFactGEP->getNumOperands() == memLocationInstGEP->getNumOperands();
  if (!hasSameNumOfOperands) return false;

  // Compare Pointer Type
  const auto gepFactOperandType = memLocationFactGEP->getOperand(0)->getType();
  const auto gepInstOperandType = memLocationInstGEP->getOperand(0)->getType();
  if (gepFactOperandType != gepInstOperandType) return false;

  // Compare Indices
  for (unsigned int i = 1; i < memLocationFactGEP->getNumOperands(); i++) {
    const auto *gepFactIndice = memLocationFactGEP->getOperand(i);
    const auto *gepInstIndice = memLocationInstGEP->getOperand(i);
    if (gepFactIndice != gepInstIndice) return false;
  }

  return true;
}

static bool
isMemoryLocationFrame(const llvm::Value* memLocation) {

  return llvm::isa<llvm::AllocaInst>(memLocation) ||
         llvm::isa<llvm::Argument>(memLocation);
}

static bool
isFirstNMemoryLocationPartsEqual(std::vector<const llvm::Value*> memLocationFactVector,
                                 std::vector<const llvm::Value*> memLocationInstVector,
                                 std::size_t n) {

  assert(n > 0);

  bool vectorsHaveAtLeastNParts = memLocationFactVector.size() >= n &&
                                  memLocationInstVector.size() >= n;
  if (!vectorsHaveAtLeastNParts) return false;

  bool haveMemLocationFrames = isMemoryLocationFrame(memLocationFactVector.front()) &&
                               isMemoryLocationFrame(memLocationInstVector.front());
  if (!haveMemLocationFrames) return false;

  assert(true && "We have vectors that both start with a memory location frame."
                 "Size may differ but we have at least n instances in each.");

  bool isSameMemLocationFrame = memLocationFactVector.front() == memLocationInstVector.front();
  if (!isSameMemLocationFrame) return false;

  for (std::size_t i = 1; i < n; ++i) {
    const auto factGEPPtr = llvm::cast<llvm::GetElementPtrInst>(memLocationFactVector[i]);
    const auto instGEPPtr = llvm::cast<llvm::GetElementPtrInst>(memLocationInstVector[i]);

    bool isEqual = isGEPPartEqual(factGEPPtr, instGEPPtr);
    if (!isEqual) return false;
  }

  return true;
}

static std::vector<const llvm::Value*>
getMemoryLocationFromFact(const ExtendedValue& fact) {

  return fact.getMemoryLocation();
}

static const llvm::Value*
getMemoryLocationFromInst(const llvm::Value* value) {

  if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(value)) {
    return storeInst->getPointerOperand();
  }

  return nullptr;
}

bool
DataFlowUtils::isValueEqual(const ExtendedValue& fact,
                            const llvm::Value* inst) {

  return fact.getValue() == inst;
}

static std::vector<const llvm::Value*>
getMemoryLocationVector(const llvm::Value* memLocation) {

  std::vector<const llvm::Value*> memLocationVector;

  bool isMemLocationFrame = isMemoryLocationFrame(memLocation);
  if (isMemLocationFrame) {
    memLocationVector.push_back(memLocation);
    return memLocationVector;
  }

  if (const auto bitCastInst = llvm::dyn_cast<llvm::BitCastInst>(memLocation)) {
    memLocationVector = getMemoryLocationVector(bitCastInst->getOperand(0));
    bool poisonVector = isUnionBitCast(bitCastInst);

    if (!poisonVector) return memLocationVector;

    // FALLTHROUGH
  }
  else if (const auto loadInst = llvm::dyn_cast<llvm::LoadInst>(memLocation)) {
    return getMemoryLocationVector(loadInst->getOperand(0));
  }
  else if (const auto gepInst = llvm::dyn_cast<llvm::GetElementPtrInst>(memLocation)) {
    memLocationVector = getMemoryLocationVector(gepInst->getPointerOperand());
    bool isVectorPoisoned = !memLocationVector.empty() && memLocationVector.back() == POISON_PILL;
    if (isVectorPoisoned) return memLocationVector;

    memLocationVector.push_back(gepInst);
    return memLocationVector;
  }

  // Poison vector
  bool isVectorPoisoned = !memLocationVector.empty() && memLocationVector.back() == POISON_PILL;
  if (!isVectorPoisoned) memLocationVector.push_back(POISON_PILL);

  return memLocationVector;
}

static std::vector<const llvm::Value*>
getSanitizedMemoryLocationVector(const llvm::Value* memLocation) {

  auto memLocationVector = getMemoryLocationVector(memLocation);

  assert(!memLocationVector.empty());

  bool isVectorPoisoned = memLocationVector.back() == POISON_PILL;
  if (isVectorPoisoned) memLocationVector.pop_back();

  return memLocationVector;
}

std::vector<const llvm::Value*>
DataFlowUtils::getMemoryLocation(const llvm::StoreInst* storeInst) {

  const auto memLocation = getMemoryLocationFromInst(storeInst);
  if (!memLocation) return std::vector<const llvm::Value*>();

  return getSanitizedMemoryLocationVector(memLocation);
}

const llvm::Value*
DataFlowUtils::getMemoryLocationFrame(const llvm::Value* memLocationInst) {

  std::vector<const llvm::Value*> memLocationVector = getMemoryLocationVector(memLocationInst);

  assert(!memLocationVector.empty());

  bool isMemLocationFrame = isMemoryLocationFrame(memLocationVector.front());
  if (isMemLocationFrame) return memLocationVector.front();

  return nullptr;
}

bool
DataFlowUtils::isMemoryLocationEqual(const ExtendedValue& fact,
                                     const llvm::Value* memLocationInst) {

  const auto memLocationFactVector = getMemoryLocationFromFact(fact);
  if (memLocationFactVector.empty()) return false;

  const auto memLocationInstVector = getSanitizedMemoryLocationVector(memLocationInst);

  bool isSameSize = memLocationFactVector.size() == memLocationInstVector.size();
  if (!isSameSize) return false;

  std::size_t allMemLocationParts = memLocationFactVector.size();
  bool isMemLocationEqual = isFirstNMemoryLocationPartsEqual(memLocationFactVector,
                                                             memLocationInstVector,
                                                             allMemLocationParts);
  if (!isMemLocationEqual) return false;

  return true;
}

bool
DataFlowUtils::isMemoryLocationFrameEqual(const ExtendedValue& fact,
                                          const llvm::Value* memLocationInst) {

  const auto memLocationFactVector = getMemoryLocationFromFact(fact);
  if (memLocationFactVector.empty()) return false;

  const llvm::Value* memLocationFrameInst = getMemoryLocationFrame(memLocationInst);
  if (memLocationFactVector.empty()) return false;

  bool isSameMemLocationFrame = memLocationFactVector[0] == memLocationFrameInst;
  if (isSameMemLocationFrame) return true;

  return false;
}

bool
DataFlowUtils::isMemoryLocationSubsetEqual(const llvm::Value* memLocationInst,
                                           const ExtendedValue& fact) {

  const auto memLocationFactVector = getMemoryLocationFromFact(fact);
  if (memLocationFactVector.empty()) return false;

  const auto memLocationInstVector = getSanitizedMemoryLocationVector(memLocationInst);
  if (memLocationInstVector.empty()) return false;

  std::size_t firstNMemoryInstances = memLocationInstVector.size();
  bool isFirstNMemoryLocationsEqual = isFirstNMemoryLocationPartsEqual(memLocationFactVector,
                                                                       memLocationInstVector,
                                                                       firstNMemoryInstances);
  if (!isFirstNMemoryLocationsEqual) return false;

  return true;
}

void
DataFlowUtils::dumpMemoryLocation(const ExtendedValue& ev) {

  if (const auto storeInst = llvm::dyn_cast<llvm::StoreInst>(ev.getValue())) {
    llvm::outs() << "TRACK: "; storeInst->print(llvm::outs()); llvm::outs() << "\n";

    for (const auto memLocationPart : ev.getMemoryLocation()) {
      llvm::outs() << "TRACK: "; memLocationPart->print(llvm::outs()); llvm::outs() << "\n";
    }
  }
}

static bool
isEndOfTaintedBranch(const llvm::BranchInst *branchInst,
                     const llvm::Instruction *instruction) {

  const auto bbInst = instruction->getParent();
  if (bbInst == nullptr) return false;

  const auto instructionLabel = bbInst->getName();
  bool isEndOfBranch = instructionLabel.contains_lower("end");
  if (!isEndOfBranch) return false;

  /*
   * We now have an instruction that belongs to the end of a branch
   * statement. We need to figure out if the label matches the one
   * of the branch statement. There are two cases to consider.
   * (1) If the branch does not have an else/else if part then we
   * can match the instruction label directly against the labels of
   * the branch instruction. (2) If there is an else/else if part
   * we need to figure out the label of the block where the branch
   * merges.
   */
  // Case 1
  const auto bbLabel1 = branchInst->getOperand(1)->getName();
  const auto bbLabel2 = branchInst->getOperand(2)->getName();

  bool isBranchWithoutElse = bbLabel1.contains_lower("end") ||
                             bbLabel2.contains_lower("end");

  if (isBranchWithoutElse) {
    bool isMatch = instructionLabel.compare_lower(bbLabel1) == 0 ||
                   instructionLabel.compare_lower(bbLabel2) == 0;
    if (isMatch) {
      return true;
    } else {
      return false;
    }
  }
  // Case 2
  /*
   * The way we determine the basic block where the branch merges
   * is as follows:
   *
   * Starting with the branch instruction whenever we encounter a
   * conditional branch instruction (beginning of a new branch)
   * we push it on the stack. Then we follow one side of the branch
   * (here left side). Whenever we encounter a basic block with an
   * "end" label (end of a branch) we pop the stack as this means
   * the branch instruction has merged. If we pop our initial branch
   * instruction the stack is empty and we have reached the merge
   * block of the branch. terminatorInstPtr will point to the
   * basic block where the branch instruction has merged.
   */
  std::stack<const llvm::BranchInst*> branchStack;

  const llvm::TerminatorInst* terminatorInstPtr = branchInst;
  do {
    if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(terminatorInstPtr)) {
      if (branchInst->isConditional()) branchStack.push(branchInst);
    }

    terminatorInstPtr = terminatorInstPtr->getSuccessor(0)->getTerminator();

    const auto bbLabel = terminatorInstPtr->getParent()->getName();
    bool isEnd = bbLabel.contains_lower("end");
    if (isEnd) branchStack.pop();
  } while (!branchStack.empty());

  const auto endOfBranchLabel = terminatorInstPtr->getParent()->getName();

  return instructionLabel.compare_lower(endOfBranchLabel) == 0;
}

static bool
isEndOfTaintedSwitch(const llvm::SwitchInst* const switchInst,
                     const llvm::Instruction *instruction) {

  const auto bbInst = instruction->getParent();
  if (bbInst == nullptr) return false;

  const auto instructionLabel = bbInst->getName();
  bool isEndOfSwitch = instructionLabel.contains_lower("epilog");
  if (!isEndOfSwitch) return false;

  /*
   * We now have an instruction that belongs to the end of a switch
   * statement. We need to figure out if the label matches the one
   * of the switch statement (e.g. we don't want to remove the switch
   * statement if it is a nested one). If the default case of the
   * switch statement points to an epilog (no default branch) we can
   * obtain the label immediately (1) if not we need to determine the
   * label of the end of the switch statement (see branch algorithm) (2).
   */
  // Case 1
  const auto defaultBB = switchInst->getDefaultDest();
  const auto defaultLabel = defaultBB->getName();
  bool isEpilogLabel = defaultLabel.contains_lower("epilog");
  if (isEpilogLabel) return instructionLabel.compare_lower(defaultLabel) == 0;

  // Case 2
  std::stack<const llvm::SwitchInst*> switchStack;

  const llvm::TerminatorInst* terminatorInstPtr = switchInst;
  do {
    if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(terminatorInstPtr)) {
      switchStack.push(switchInst);
    }

    terminatorInstPtr = terminatorInstPtr->getSuccessor(0)->getTerminator();

    const auto bbLabel = terminatorInstPtr->getParent()->getName();
    bool isEpilog = bbLabel.contains_lower("epilog");
    if (isEpilog) switchStack.pop();
  } while (!switchStack.empty());

  const auto endOfSwitchLabel = terminatorInstPtr->getParent()->getName();

  return instructionLabel.compare_lower(endOfSwitchLabel) == 0;
}

bool
DataFlowUtils::isEndOfBranchOrSwitchInst(const ExtendedValue& fact,
                                         const llvm::Instruction *instruction) {

  const auto branchOrSwitchInst = fact.getValue();

  if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(branchOrSwitchInst)) {
    return isEndOfTaintedBranch(branchInst, instruction);
  }
  else if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(branchOrSwitchInst)) {
    return isEndOfTaintedSwitch(switchInst, instruction);
  }

  return false;
}
