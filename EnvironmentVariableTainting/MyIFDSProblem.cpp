#include "MyIFDSProblem.h"

#include <iostream>
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/CallSite.h"

#include "phasar/PhasarLLVM/IfdsIde/FlowFunctions/Identity.h"
#include "phasar/PhasarLLVM/ControlFlow/LLVMBasedICFG.h"

using namespace std;
using namespace psr;

unique_ptr<IFDSTabulationProblemPlugin> makeMyIFDSProblem(
    LLVMBasedICFG &I, vector<string> EntryPoints) {
  return unique_ptr<IFDSTabulationProblemPlugin>(
      new MyIFDSProblem(I, EntryPoints));
}

__attribute__((constructor)) void init() {
  cout << "init - MyIFDSProblem\n";
  IFDSTabulationProblemPluginFactory["ifds_testplugin"] = &makeMyIFDSProblem;
}

__attribute__((destructor)) void fini() { cout << "fini - MyIFDSProblem\n"; }

MyIFDSProblem::MyIFDSProblem(LLVMBasedICFG &I, vector<string> EntryPoints)
    : IFDSTabulationProblemPlugin(I, EntryPoints) {}

MyIFDSProblem::~MyIFDSProblem() {
  llvm::outs() << "FINDINGS:\n";
  for (auto Leak : Leaks) {
    Leak.first->print(llvm::outs());
    llvm::outs() << '\n';
    for (auto Value : Leak.second) {
      Value->print(llvm::outs());
      llvm::outs() << '\n';
    }
  }
}

shared_ptr<FlowFunction<const llvm::Value *>>
MyIFDSProblem::getNormalFlowFunction(const llvm::Instruction *curr,
                                     const llvm::Instruction *succ) {
  cout << "MyIFDSProblem::getNormalFlowFunction()\n";
  if (auto Store = llvm::dyn_cast<llvm::StoreInst>(curr)) {
    struct MFF : FlowFunction<const llvm::Value *> {
      const llvm::StoreInst *Store;
      MFF(const llvm::StoreInst *S) : Store(S) {}
      set<const llvm::Value *> computeTargets(const llvm::Value *Src) {
        if (Src == Store->getValueOperand()) {
          return {Src, Store->getPointerOperand()};
        } else {
          return {Src};
        }
      }
    };
    return make_shared<MFF>(Store);
  }
  if (auto Load = llvm::dyn_cast<llvm::LoadInst>(curr)) {
    struct MFF : FlowFunction<const llvm::Value *> {
      const llvm::LoadInst *Load;
      MFF(const llvm::LoadInst *L) : Load(L) {}
      set<const llvm::Value *> computeTargets(const llvm::Value *Src) {
        if (Src == Load->getPointerOperand()) {
          return {Src, Load};
        } else {
          return {Src};
        }
      }
    };
    return make_shared<MFF>(Load);
  }
  return Identity<const llvm::Value *>::getInstance();
}

shared_ptr<FlowFunction<const llvm::Value *>>
MyIFDSProblem::getCallFlowFunction(const llvm::Instruction *callStmt,
                                   const llvm::Function *destMthd) {
  cout << "MyIFDSProblem::getCallFlowFunction()\n";
  if (destMthd->getName() == "taint" || destMthd->getName() == "leak" ||
      destMthd->getName() == "print") {
    return KillAll<const llvm::Value *>::getInstance();
  }

  // Map the actual into the formal parameters
  if (llvm::isa<llvm::CallInst>(callStmt) ||
      llvm::isa<llvm::InvokeInst>(callStmt)) {
    llvm::ImmutableCallSite CallSite(callStmt);
    // Do the mapping
    struct TAFF : FlowFunction<const llvm::Value *> {
      llvm::ImmutableCallSite callSite;
      const llvm::Function *destMthd;
      const llvm::Value *zerovalue;
      vector<const llvm::Value *> actuals;
      vector<const llvm::Value *> formals;
      TAFF(llvm::ImmutableCallSite cs, const llvm::Function *dm,
           const llvm::Value *zv)
          : callSite(cs), destMthd(dm), zerovalue(zv) {
        // set up the actual parameters
        for (unsigned idx = 0; idx < callSite.getNumArgOperands(); ++idx) {
          actuals.push_back(callSite.getArgOperand(idx));
        }
        // set up the formal parameters
        for (unsigned idx = 0; idx < destMthd->arg_size(); ++idx) {
          formals.push_back(getNthFunctionArgument(destMthd, idx));
        }
      }
      set<const llvm::Value *> computeTargets(const llvm::Value *source) {
        if (source != zerovalue) {
          set<const llvm::Value *> res;
          for (unsigned idx = 0; idx < actuals.size(); ++idx) {
            if (source == actuals[idx]) {
              res.insert(formals[idx]);  // corresponding formal
              res.insert(zerovalue);
            }
          }
          return res;
        } else {
          return {source};
        }
      }
    };
    return make_shared<TAFF>(CallSite, destMthd, zeroValue());
  }

  return Identity<const llvm::Value *>::getInstance();
}

shared_ptr<FlowFunction<const llvm::Value *>> MyIFDSProblem::getRetFlowFunction(
    const llvm::Instruction *callSite, const llvm::Function *calleeMthd,
    const llvm::Instruction *exitStmt, const llvm::Instruction *retSite) {
  cout << "MyIFDSProblem::getRetFlowFunction()\n";
  // We must check if the return value is tainted, if so we must taint
  // all useres of the function call.
  struct TAFF : FlowFunction<const llvm::Value *> {
    llvm::ImmutableCallSite callSite;
    const llvm::Function *calleeMthd;
    const llvm::ReturnInst *exitStmt;
    const llvm::Value *zerovalue;
    vector<const llvm::Value *> actuals;
    vector<const llvm::Value *> formals;
    TAFF(llvm::ImmutableCallSite callsite, const llvm::Function *callemthd,
         const llvm::Instruction *exitstmt, const llvm::Value *zv)
        : callSite(callsite),
          calleeMthd(callemthd),
          exitStmt(llvm::dyn_cast<llvm::ReturnInst>(exitstmt)),
          zerovalue(zv) {
      // set up the actual parameters
      for (unsigned idx = 0; idx < callSite.getNumArgOperands(); ++idx) {
        actuals.push_back(callSite.getArgOperand(idx));
      }
      // set up the formal parameters
      for (unsigned idx = 0; idx < calleeMthd->arg_size(); ++idx) {
        formals.push_back(getNthFunctionArgument(calleeMthd, idx));
      }
    }
    set<const llvm::Value *> computeTargets(
        const llvm::Value *source) override {
      if (source != zerovalue) {
        set<const llvm::Value *> res;
        res.insert(zerovalue);
        // collect everything that is returned by value and pointer/ reference
        for (unsigned idx = 0; idx < formals.size(); ++idx) {
          if (source == formals[idx] &&
              formals[idx]->getType()->isPointerTy()) {
            res.insert(actuals[idx]);
          }
        }
        // collect taints returned by return value
        if (source == exitStmt->getReturnValue()) {
          res.insert(callSite.getInstruction());
        }
        return res;
      }
      // else just draw the zero edge
      return {source};
    }
  };
  return make_shared<TAFF>(llvm::ImmutableCallSite(callSite), calleeMthd,
                           exitStmt, zeroValue());
  // All other stuff is killed at this point
}

shared_ptr<FlowFunction<const llvm::Value *>>
MyIFDSProblem::getCallToRetFlowFunction(const llvm::Instruction *callSite,
                                        const llvm::Instruction *retSite,
                                        set<const llvm::Function *> callees) {
  cout << "MyIFDSProblem::getCallToRetFlowFunction()\n";
  if (llvm::isa<llvm::CallInst>(callSite) ||
      llvm::isa<llvm::InvokeInst>(callSite)) {
    llvm::ImmutableCallSite CS(callSite);
    if (CS.getCalledFunction()->getName().str() == "taint") {
      return make_shared<Gen<const llvm::Value *>>(callSite, zeroValue());
    }
    if (CS.getCalledFunction()->getName().str() == "leak" ||
        CS.getCalledFunction()->getName().str() == "print") {
      struct MFF : FlowFunction<const llvm::Value *> {
        map<const llvm::Instruction *, set<const llvm::Value *>> &Leaks;
        llvm::ImmutableCallSite CS;
        const llvm::Value *ZV;
        MFF(map<const llvm::Instruction *, set<const llvm::Value *>> &L,
            llvm::ImmutableCallSite C, const llvm::Value *Z)
            : Leaks(L), CS(C), ZV(Z) {}
        set<const llvm::Value *> computeTargets(const llvm::Value *Src) {
          for (unsigned Idx = 0; Idx < CS.getNumArgOperands(); ++Idx) {
            if (Src != ZV && Src == CS.getArgOperand(Idx)) {
              cout << "ALERT FOUND A LEAK!\n";
              Leaks[CS.getInstruction()].insert(Src);
            }
          }
          return {Src};
        }
      };
      return make_shared<MFF>(Leaks, CS, zeroValue());
    }
  }
  return Identity<const llvm::Value *>::getInstance();
}


shared_ptr<FlowFunction<const llvm::Value *>>
MyIFDSProblem::getSummaryFlowFunction(const llvm::Instruction *callStmt,
                                      const llvm::Function *destMthd) {
  cout << "MyIFDSProblem::getSummaryFlowFunction()\n";
  // Let phasar take care of the special LLVM intrinsic and libc functions
  return nullptr;
}

map<const llvm::Instruction *, set<const llvm::Value *>>
MyIFDSProblem::initialSeeds() {
  cout << "MyIFDSProblem::initialSeeds()\n";
  map<const llvm::Instruction *, set<const llvm::Value *>> SeedMap;
  for (auto &EntryPoint : EntryPoints) {
    SeedMap.insert(std::make_pair(&icfg.getMethod(EntryPoint)->front().front(),
                                  set<const llvm::Value *>({zeroValue()})));
  }
  return SeedMap;
}
