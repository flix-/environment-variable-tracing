#ifndef MONOINTRAPLUGINTEST_H
#define MONOINTRAPLUGINTEST_H

#include <phasar/PhasarLLVM/Plugins/Interfaces/Mono/IntraMonoProblemPlugin.h>

namespace psr {

class MonoIntraPluginTest
    : public IntraMonoProblemPlugin {

public:
  MonoIntraPluginTest(LLVMBasedCFG& cfg, const llvm::Function* f) : IntraMonoProblemPlugin(cfg, f) {}
  virtual ~MonoIntraPluginTest() override = default;

  MonoSet<const llvm::Value*> join(const MonoSet<const llvm::Value*> &Lhs, const MonoSet<const llvm::Value*> &Rhs) override;
  bool sqSubSetEqual(const MonoSet<const llvm::Value*> &Lhs, const MonoSet<const llvm::Value*> &Rhs) override;
  MonoSet<const llvm::Value*> flow(const llvm::Instruction* S, const MonoSet<const llvm::Value*> &In) override;
  MonoMap<const llvm::Instruction*, MonoSet<const llvm::Value*>> initialSeeds() override;

  void printReport() override;

};

} // namespace
#endif // MONOINTRAPLUGINTEST_H
