#include "DataFlowUtils.h"

#include <stack>

#include <llvm/Support/raw_ostream.h>

using namespace psr;

static bool
isEndOfTaintedBranch(const llvm::BranchInst *branchInst, const llvm::Instruction *instruction) {
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
DataFlowUtils::isEndOfBranchOrSwitchInst(const llvm::Value *branchOrSwitchInst, const llvm::Instruction *instruction) {
  if (const auto branchInst = llvm::dyn_cast<llvm::BranchInst>(branchOrSwitchInst)) {
    return isEndOfTaintedBranch(branchInst, instruction);
  }
  else if (const auto switchInst = llvm::dyn_cast<llvm::SwitchInst>(branchOrSwitchInst)) {
    return isEndOfTaintedSwitch(switchInst, instruction);
  }
  return false;
}

void
DataFlowUtils::dumpFacts(const MonoSet<const llvm::Value*>& facts) {
  llvm::outs() << "Dumping facts" << "\n";
  llvm::outs() << "=============" << "\n";
  for (const auto fact : facts) {
    fact->print(llvm::outs()); llvm::outs() << "\n";
  }
  llvm::outs() << "=============" << "\n";
  llvm::outs() << "\n";
}
