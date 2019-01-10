add_library(IFDSEnvironmentVariableTracing MODULE
  IFDSEnvironmentVariableTracing.h
  IFDSEnvironmentVariableTracing.cpp
  LineNumberStore.h
  LineNumberStore.cpp

  FlowFunctions/FlowFunctionWrapper.h
  FlowFunctions/FlowFunctionWrapper.cpp
  FlowFunctions/Identity.h
  FlowFunctions/MapTaintedArgsToCallee.h
  FlowFunctions/MapTaintedArgsToCallee.cpp

  Utils/DataFlowUtils.h
  Utils/DataFlowUtils.cpp
  Utils/LLVMIRDump.h
  Utils/LLVMIRDump.cpp
)
