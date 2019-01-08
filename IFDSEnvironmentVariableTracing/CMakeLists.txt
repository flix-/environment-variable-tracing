add_library(IFDSEnvironmentVariableTracing MODULE
  LLVMIRDump.h
  LLVMIRDump.cpp

  LineNumberStore.h
  LineNumberStore.cpp
  MapTaintedArgsToCallee.h
  MapTaintedArgsToCallee.cpp
  DataFlowUtils.h
  DataFlowFacts.cpp
  DataFlowFacts.h
  DataFlowFacts.cpp
  IFDSEnvironmentVariableTracing.h
  IFDSEnvironmentVariableTracing.cpp
)
