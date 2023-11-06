cmake_minimum_required(VERSION 3.13) # CMake version check
project(deadlock_example) # Create project "simple_example"
set(CMAKE_CXX_STANDARD 14) # Enable c++14 standard

# Add main.cpp file of project root directory as source file
set(SOURCE_FILES main.cpp)

# Add executable target with source files listed in SOURCE_FILES variable
add_executable(deadlock_example ${SOURCE_FILES})

# target_compile_options(
#   deadlock_example PRIVATE -fsanitize=address )
# target_link_options(
#   deadlock_example PRIVATE -fsanitize=address)
