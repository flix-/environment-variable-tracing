#include "MonoIntraPluginTest.h"

#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Value.h>

#include <algorithm>
#include <iostream>

namespace psr {

// Factory function that is used to create an instance by the Phasar framework.
static std::unique_ptr<IntraMonoProblemPlugin>
makeIntraMonoProblemPlugin(LLVMBasedCFG& cfg,
                           const llvm::Function* f) {
  return std::unique_ptr<IntraMonoProblemPlugin>(new MonoIntraPluginTest(cfg, f));
}

// Is executed on plug-in load and has to register this plug-in to Phasar.
__attribute__((constructor)) void init() {
  std::cout << "init - MonoIntraPluginTest" << "\n";
  IntraMonoProblemPluginFactory["mono"] = &makeIntraMonoProblemPlugin;
}

// Is executed on unload, can be used to unregister the plug-in.
__attribute__((destructor)) void finish() {
  std::cout << "finish - MonoIntraPluginTest" << "\n";
}

MonoSet<const llvm::Value*>
MonoIntraPluginTest::join(const MonoSet<const llvm::Value*> &Lhs,
                          const MonoSet<const llvm::Value*> &Rhs) {
  std::cout << "join()" << "\n";
  MonoSet<const llvm::Value*> Result;
  std::set_union(Lhs.begin(), Lhs.end(), Rhs.begin(), Rhs.end(),
    inserter(Result, Result.begin()));
  return Result;
}

bool
MonoIntraPluginTest::sqSubSetEqual(const MonoSet<const llvm::Value*> &Lhs,
                                   const MonoSet<const llvm::Value*> &Rhs) {
  std::cout << "sqSubSetEqual()" << "\n";
  return std::includes(Rhs.begin(), Rhs.end(), Lhs.begin(), Lhs.end());
}

MonoSet<const llvm::Value*>
MonoIntraPluginTest::flow(const llvm::Instruction* S,
                          const MonoSet<const llvm::Value*> &In) {
  std::cout << "flow()" << "\n";
  MonoSet<const llvm::Value*> Result;
  if (const auto Store = llvm::dyn_cast<llvm::StoreInst>(S)) {
    Result.insert(Store);
  }
  return Result;
}

MonoMap<const llvm::Instruction*, MonoSet<const llvm::Value*>>
MonoIntraPluginTest::initialSeeds() {
  std::cout << "initialSeeds()" << "\n";
  return {};
}

} // namespace
