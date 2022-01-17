# Look for Python3
find_package(Python3 REQUIRED COMPONENTS Interpreter Development.Module)

# Look for SWIG 4
find_package(SWIG 4.0 REQUIRED)
include(${SWIG_USE_FILE})

# Variables
set(SRC fibo.i)
set(PACKAGE_NAME myfibopy) # Keep sync with setup.py and ${SRC} content
set(CMAKE_SWIG_OUTDIR ${CMAKE_CURRENT_BINARY_DIR}/${PACKAGE_NAME}) # Package building output folder

# SWIG interface source file
set_source_files_properties(${SRC} PROPERTIES
  CPLUSPLUS ON
  # Swig wrapper will be regenerated if C++ headers are changed
  # https://stackoverflow.com/a/70375654/3952924
  USE_SWIG_DEPENDENCIES TRUE
  # myfibo C++ headers will be found by %import directive
  USE_TARGET_INCLUDE_DIRECTORIES TRUE
  # One python package (no module name)
  SWIG_MODULE_NAME __init__
)

# SWIG flags
set(CMAKE_SWIG_FLAGS -py3 -keyword)
# Note: Cannot use -doxygen feature as all documentation is in C++ bodies

# SWIG target (generates _myfibopy.so and myfibopy.py)
swig_add_library(
  ${PACKAGE_NAME}
  LANGUAGE   python
  TYPE       SHARED
  SOURCES    ${SRC})

# Find appropriate Python.h
target_include_directories(${PACKAGE_NAME} PRIVATE ${Python3_INCLUDE_DIRS})

# Link to static myfibo library
target_link_libraries(${PACKAGE_NAME} PUBLIC myfibo)

# For location of SWIG library to SWIG output directory
set_target_properties(${PACKAGE_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SWIG_OUTDIR})

# Build and install python package
add_custom_command(TARGET ${PACKAGE_NAME}
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/setup.py .
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/README.md .
  COMMAND ${Python3_EXECUTABLE} -m pip install .
  COMMENT "Installing python package"
  VERBATIM)

