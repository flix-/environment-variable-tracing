cmake_minimum_required(VERSION 3.12)
project(Phasar)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DDEBUG_BUILD")

set(LLVM_DIR /home/sebastian/documents/programming/llvm/jail/llvm501-release/lib/cmake/llvm)
find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

if(NOT ${LLVM_ENABLE_RTTI})
  message(STATUS "Disabling RTTI")
  set(CMAKE_CXX_FLAGS "-fno-rtti")
endif()

add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})

# add llvm sources to inspect source code within ide
#file(GLOB_RECURSE LLVM_SOURCES
#  /home/sebastian/documents/programming/llvm/src/llvm501/lib/*.cpp
#  /home/sebastian/documents/programming/llvm/src/llvm501/lib/*.c
#)
# add phasar sources to inspect source code within ide
#file(GLOB_RECURSE PHASAR_SOURCES
#  /home/sebastian/documents/programming/phasar-1218/lib/*.cpp
#  /home/sebastian/documents/programming/phasar-1218/lib/*.cxx
#  /home/sebastian/documents/programming/phasar-1218/tools/*.cpp
#)
#add_custom_target(LLVM_SOURCES SOURCES ${LLVM_SOURCES})
#add_custom_target(PHASAR_SOURCES SOURCES ${PHASAR_SOURCES})

add_subdirectory(IFDSEnvironmentVariableTracing)

