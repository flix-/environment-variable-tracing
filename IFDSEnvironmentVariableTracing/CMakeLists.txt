add_library(IFDSEnvironmentVariableTracing MODULE
  IFDSEnvironmentVariableTracing.h
  IFDSEnvironmentVariableTracing.cpp
  LineNumberStore.h
  LineNumberStore.cpp

  FlowFunctions/FlowFunctionWrapper.h
  FlowFunctions/FlowFunctionWrapper.cpp
  FlowFunctions/Identity.h
  FlowFunctions/MapTaintedValuesToCallee.h
  FlowFunctions/MapTaintedValuesToCallee.cpp
  FlowFunctions/MapTaintedValuesToCaller.h
  FlowFunctions/MapTaintedValuesToCaller.cpp

  Utils/DataFlowUtils.h
  Utils/DataFlowUtils.cpp
  Utils/LLVMIRDump.h
  Utils/LLVMIRDump.cpp
)
