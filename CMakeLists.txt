#########
# GCC
#########
# Build static library (and install python package)
# cmake -Bbuild -H. -DBUILD_PYTHON=ON
# cmake --build build

# Build and install static library (and don't build python package)
# cmake -Bbuild -H. -DCMAKE_INSTALL_PREFIX=/home/fors/myfibo_install
# cmake --build build --target install

#########
# MSVC
#########
# Build static library (and install python package)
# cmake -Bbuild -H. -DBUILD_PYTHON=ON
# cmake --build build --config Release

# Build and install static library (and don't build python package)
# cmake -Bbuild -H. -DCMAKE_INSTALL_PREFIX=C:/users/user/myfibo_install
# cmake --build build --target install --config Release

cmake_minimum_required(VERSION 3.20)

project(myfibopy
  VERSION      0.0.1
  DESCRIPTION  "Fibonacci"
  HOMEPAGE_URL https://github.com/fabien-ors/myfibo
  LANGUAGES    C CXX # Enable C language for third party libraries
)

# Get the date in gstlearn_DATE variable
string(TIMESTAMP myfibo_DATE "%Y/%m/%d")

# Fix version.h automatically
configure_file(version.h.in version.h)

# Add python option
option(BUILD_PYTHON "Build Python Library" OFF)
message(STATUS "Build Python: ${BUILD_PYTHON}")

# Make Release version the default
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'Release' as none was specified")
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Impose 'd' suffix in debug (global property)
set(CMAKE_DEBUG_POSTFIX d)

add_subdirectory(src)
add_subdirectory(python)

# Add uninstall target
# https://gitlab.kitware.com/cmake/community/-/wikis/FAQ#can-i-do-make-uninstall-with-cmake
if(NOT TARGET uninstall)
  configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
    IMMEDIATE @ONLY)

  add_custom_target(uninstall
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)
endif()
