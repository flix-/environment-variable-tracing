add_library(EnvironmentVariableTainting MODULE
  DataFlowUtils.h
  DataFlowUtils.cpp
  DataFlowFacts.h
  DataFlowFacts.cpp
  MonoIntraEnvironmentVariableTracing.h
  MonoIntraEnvironmentVariableTracing.cpp
)
