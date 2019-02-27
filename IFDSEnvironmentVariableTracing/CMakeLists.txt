add_library(IFDSEnvironmentVariableTracing MODULE
  IFDSEnvironmentVariableTracing.h
  IFDSEnvironmentVariableTracing.cpp

  FlowFunctions/FlowFunctionBase.h
  FlowFunctions/FlowFunctionBase.cpp
  FlowFunctions/StoreInstFlowFunction.h
  FlowFunctions/StoreInstFlowFunction.cpp
  FlowFunctions/BranchSwitchInstFlowFunction.h
  FlowFunctions/BranchSwitchInstFlowFunction.cpp
  FlowFunctions/GEPInstFlowFunction.h
  FlowFunctions/GEPInstFlowFunction.cpp
  FlowFunctions/PHINodeFlowFunction.h
  FlowFunctions/PHINodeFlowFunction.cpp
  FlowFunctions/CheckOperandsFlowFunction.h
  FlowFunctions/CheckOperandsFlowFunction.cpp
  FlowFunctions/ReturnInstFlowFunction.h
  FlowFunctions/ReturnInstFlowFunction.cpp
  FlowFunctions/CallToRetFlowFunction.h
  FlowFunctions/CallToRetFlowFunction.cpp
  FlowFunctions/MemTransferInstFlowFunction.h
  FlowFunctions/MemTransferInstFlowFunction.cpp
  FlowFunctions/MemSetInstFlowFunction.h
  FlowFunctions/MemSetInstFlowFunction.cpp
  FlowFunctions/VAStartInstFlowFunction.h
  FlowFunctions/VAStartInstFlowFunction.cpp
  FlowFunctions/VAEndInstFlowFunction.h
  FlowFunctions/VAEndInstFlowFunction.cpp

  FlowFunctions/IdentityFlowFunction.h
  FlowFunctions/IdentityFlowFunction.cpp
  FlowFunctions/GenerateFlowFunction.h
  FlowFunctions/GenerateFlowFunction.cpp

  FlowFunctions/MapTaintedValuesToCallee.h
  FlowFunctions/MapTaintedValuesToCallee.cpp
  FlowFunctions/MapTaintedValuesToCaller.h
  FlowFunctions/MapTaintedValuesToCaller.cpp

  Stats/TraceStats.h
  Stats/TraceStats.cpp

  Stats/TraceStatsModel.h

  Stats/TraceStatsWriter.h
  Stats/LineNumberWriter.h
  Stats/LineNumberWriter.cpp
  Stats/LcovWriter.h
  Stats/LcovWriter.cpp

  Utils/DataFlowUtils.h
  Utils/DataFlowUtils.cpp
)
