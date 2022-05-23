##############
# GCC / MSYS
##############
# Build static library (and install python package)
# cmake -Bbuild -H.
# cmake --build build --target python_install

# Build and install shared library (and don't build python package)
# cmake -Bbuild -H.
# cmake --build build --target install

#########
# MSVC
#########
# Build static library (and install python package)
# cmake -Bbuild -H.
# cmake --build build --target python_install --config Release

# Build and install shared library (and don't build python package)
# cmake -Bbuild -H.
# cmake --build build --target install --config Release

# For recent UseSWIG
cmake_minimum_required(VERSION 3.20)

# Verbose makefiles
#set(CMAKE_VERBOSE_MAKEFILE ON)

# Define project here
project(myfibo
  VERSION      0.0.14
  DESCRIPTION  "Fibonacci simple C++ library and packages"
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

# Activate verbose mode
#set(CMAKE_VERBOSE_MAKEFILE ON)

# Options
option(BUILD_PYTHON "Build python package")
option(BUILD_R      "Build R package")
if(NOT BUILD_PYTHON)
  set(BUILD_PYTHON ON)
endif()
if(NOT BUILD_R)
  set(BUILD_R ON)
endif()
if (MINGW)
  set(BUILD_PYTHON OFF)
endif()
if (MSVC)
  set(BUILD_R OFF)
endif()
message(STATUS "BUILD_PYTHON=" ${BUILD_PYTHON})
message(STATUS "BUILD_R="      ${BUILD_R})

# Universal binary for Mac
set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "Build architectures for Mac OS X" FORCE)

####################################################
## BUILD & INSTALL

include(cmake/cpp.cmake)
# TODO : Add doxygen feature
#include(cmake/doxygen.cmake)
include(cmake/install.cmake)


####################################################
## PACKAGES

add_subdirectory(python)
add_subdirectory(r)

####################################################
## TESTING

# Add non-regression test target
include(CTest)
enable_testing()

add_subdirectory(tests)
