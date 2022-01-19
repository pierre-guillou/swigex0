# Look for Python3
find_package(Python3 REQUIRED COMPONENTS Interpreter Development.Module)

# Look for SWIG 4
find_package(SWIG 4.0 REQUIRED)
include(${SWIG_USE_FILE})

# Variables
set(SRC fibo.i) # Interface file
set(PACKAGE_NAME myfibopy) # Keep sync with interface file content
set(PACKAGE_ROOT_FOLDER            ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>)
set(PACKAGE_DESTINATION_FOLDER     ${PACKAGE_ROOT_FOLDER}/${PACKAGE_NAME})
# Location for target language code
set(CMAKE_SWIG_OUTDIR              ${PACKAGE_DESTINATION_FOLDER})
# Location for wrapper library
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PACKAGE_DESTINATION_FOLDER}) # Use LIBRARY (gcc)!
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PACKAGE_DESTINATION_FOLDER}) # Use RUNTIME (msvc)!

# SWIG interface source file
set_source_files_properties(${SRC} PROPERTIES
  CPLUSPLUS ON
  # Swig wrapper will be regenerated if C++ headers are changed
  # https://stackoverflow.com/a/70375654/3952924
  #USE_SWIG_DEPENDENCIES TRUE   # Incompatible with CMAKE_SWIG_OUTDIR under Windows cmake 3.22
  # myfibo C++ headers will be found by %import directive
  USE_TARGET_INCLUDE_DIRECTORIES TRUE
  # Python package will be the installed folder name (no module name)
  SWIG_MODULE_NAME __init__
)

# SWIG flags
set(CMAKE_SWIG_FLAGS -py3 -keyword)
# Note: Cannot use -doxygen feature as all documentation is in C++ bodies

# SWIG target (generates wrapper then _myfibopy.so and myfibopy.py)
swig_add_library(
  ${PACKAGE_NAME}
  LANGUAGE   python
  TYPE       SHARED
  SOURCES    ${SRC})
  
# Link to static myfibo library
target_link_libraries(${PACKAGE_NAME} PUBLIC myfibo)

# Find appropriate Python.h
target_include_directories(${PACKAGE_NAME} PRIVATE ${Python3_INCLUDE_DIRS})

# Link to python libraries (only for MSVC)
if(MSVC)
  target_link_libraries(${PACKAGE_NAME} PRIVATE ${Python3_LIBRARIES})
endif()

# Build and install python package
add_custom_command(TARGET ${PACKAGE_NAME}
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/setup.py ${PACKAGE_ROOT_FOLDER}
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/README.md ${PACKAGE_ROOT_FOLDER}
  COMMAND ${Python3_EXECUTABLE} -m pip install ${PACKAGE_ROOT_FOLDER}
  COMMENT "Installing python package"
  VERBATIM)

