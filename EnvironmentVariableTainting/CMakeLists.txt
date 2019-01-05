add_library(EnvironmentVariableTainting MODULE
  DataFlowUtils.h
  DataFlowUtils.cpp
  DataFlowFacts.h
  DataFlowFacts.cpp
  LineNumberStore.h
  LineNumberStore.cpp
  MonoIntraEnvironmentVariableTracing.h
  MonoIntraEnvironmentVariableTracing.cpp
)
