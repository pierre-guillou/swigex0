#########
# GCC
#########
# Build static library (and install python package)
# cmake -Bbuild -H. -DBUILD_PYTHON=ON
# cmake --build build

# Build and install shared library (and don't build python package)
# cmake -Bbuild -H. -DCMAKE_INSTALL_PREFIX=/home/fors/myfibo_install
# cmake --build build --target install

#########
# MSVC
#########
# Build static library (and install python package)
# cmake -Bbuild -H. -DBUILD_PYTHON=ON
# cmake --build build --config Release

# Build and install shared library (and don't build python package)
# cmake -Bbuild -H. -DCMAKE_INSTALL_PREFIX=C:/users/user/myfibo_install
# cmake --build build --target install --config Release

cmake_minimum_required(VERSION 3.20)

# Define project here
project(myfibo
  VERSION      0.0.1
  DESCRIPTION  "Fibonacci simple class"
  HOMEPAGE_URL "https://github.com/fabien-ors/myfibo"
  LANGUAGES    C CXX # Enable C language for third party libraries
)

####################################################
## CONFIGURATION

# Get the project date
string(TIMESTAMP ${PROJECT_NAME}_DATE "%Y/%m/%d - %H:%M")

# Convert project name to uppercase
string(TOUPPER ${PROJECT_NAME} PROJECT_NAME_UP)

# Fix version.h automatically
configure_file(version.h.in version.h)

# Add configuration options (Build shared only by default)
option(BUILD_STATIC "Build Static Library" OFF)
option(BUILD_SHARED "Build Shared Library" ON)
option(BUILD_PYTHON "Build and Install Python Package" OFF)
option(BUILD_TESTS "Build C++ Non-Regression Tests" OFF)

# Test if static library is needed
if (BUILD_PYTHON)
  set(BUILD_STATIC ON)
endif()

# Test if building tests is needed
if (RUN_TESTS)
  set(BUILD_TESTS ON)
endif()

# Test if shared library is needed
if (BUILD_TESTS)
  set(BUILD_SHARED ON)
endif()

# Display configuration
message(STATUS "BUILD_STATIC = ${BUILD_STATIC}")
message(STATUS "BUILD_SHARED = ${BUILD_SHARED}")
message(STATUS "BUILD_PYTHON = ${BUILD_PYTHON}")
message(STATUS "BUILD_TESTS  = ${BUILD_TESTS}")
if (NOT BUILD_SHARED AND NOT BUILD_STATIC)
  message(FATAL_ERROR "You must build at least shared or static library!")
endif()

####################################################
## BUILD

# Make Release version the default
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'Release' as none was specified")
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Activate verbose mode
#set(CMAKE_VERBOSE_MAKEFILE ON)

# Add c++11 support whatever the compiler
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Warning fiesta!
# https://cmake.org/cmake/help/latest/command/add_compile_options.html
if (MSVC)
  # Warning level 4 (4 = maximum, 0 = none)
  add_compile_options(/W4) 
else()
  # Lots of warnings (-Wall = add some warnings, -Wextra = add a ton of warnings)
  add_compile_options(-Wextra)
endif()

include(cmake/cpp.cmake)
#include(cmake/doxygen.cmake)
#include(cmake/doc.cmake)
include(cmake/install.cmake)


####################################################
## PACKAGES

add_subdirectory(python)



####################################################
## TESTING

# Add test target (execution)
include(CTest)
enable_testing()

add_subdirectory(tests)


