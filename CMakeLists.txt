cmake_minimum_required(VERSION 3.13)
project(deadlock_example)
set(CMAKE_CXX_STANDARD 14)

set(SOURCE_FILES main.cpp)

add_executable(deadlock_example ${SOURCE_FILES})
