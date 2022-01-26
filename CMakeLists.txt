#########
# GCC
#########
# Build static library (and install python package)
# cmake -Bbuild -H.
# cmake --build build --target python

# Build and install shared library (and don't build python package)
# cmake -Bbuild -H. -DCMAKE_INSTALL_PREFIX=/home/fors/myfibo_install
# cmake --build build --target install

#########
# MSVC
#########
# Build static library (and install python package)
# cmake -Bbuild -H.
# cmake --build build --target python --config Release

# Build and install shared library (and don't build python package)
# cmake -Bbuild -H. -DCMAKE_INSTALL_PREFIX=C:/users/user/myfibo_install
# cmake --build build --target install --config Release

# For recent UseSWIG
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
# TODO : Add doxygen feature
#include(cmake/doxygen.cmake)
include(cmake/install.cmake)


####################################################
## PACKAGES

add_subdirectory(python)


####################################################
## TESTING

# Add build_test and test targets
include(CTest)
enable_testing()

add_subdirectory(tests)


