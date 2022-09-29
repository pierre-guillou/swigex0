if(NOT BUILD_PYTHON)
  return()
endif()

# Python package name
set(PYTHON_PACKAGE_NAME ${PROJECT_NAME})
# Beware : the real package name is the PROJECT_NAME (for better import)

###################################
# DEPENDENCIES

# Look for Python3
#set(CMAKE_FIND_DEBUG_MODE TRUE)
find_package(Python3 REQUIRED COMPONENTS Interpreter Development.Module NumPy)

# Look for SWIG 4
find_package(SWIG 4.0 REQUIRED)
# TODO : If SWIG not found, fetch it from the web?
include(${SWIG_USE_FILE})


######################################
# WRAPPER GENERATION & BUILD

# Python package interface file
set(SRC pyswigex.i) 

# Generation folders
if (CMAKE_CONFIGURATION_TYPES)
  set(PYTHON_PACKAGE_ROOT_FOLDER      ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>)
else()
  set(PYTHON_PACKAGE_ROOT_FOLDER      ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE})
endif()
set(PYTHON_PACKAGE_DESTINATION_FOLDER ${PYTHON_PACKAGE_ROOT_FOLDER}/${PYTHON_PACKAGE_NAME})
# Location for SWIG target language code
set(CMAKE_SWIG_OUTDIR                 ${PYTHON_PACKAGE_DESTINATION_FOLDER})
# Location for SWIG wrapper library
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY    ${PYTHON_PACKAGE_DESTINATION_FOLDER}) # Use LIBRARY (gcc)!
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY    ${PYTHON_PACKAGE_DESTINATION_FOLDER}) # Use RUNTIME (msvc)!

# SWIG interface source file properties
set_source_files_properties(${SRC} PROPERTIES
  CPLUSPLUS ON
  # Swig wrapper will be regenerated if C++ headers are changed
  # https://stackoverflow.com/a/70375654/3952924 (CMake 3.20 minimum)
  USE_SWIG_DEPENDENCIES TRUE
  # swigex C++ headers will be found by %import swig directive
  USE_TARGET_INCLUDE_DIRECTORIES TRUE
  # Python package name will be the name of the installed folder (no module)
  SWIG_MODULE_NAME __init__
)

# Tell to CMake that ${SRC} depends on some other files
# TODO: This only works on GCC because MSVC always recompile swig (don't know why)
set_property(SOURCE ${SRC} PROPERTY
  DEPENDS
    ${PROJECT_SOURCE_DIR}/swig/swig_exp.i
    ${PROJECT_SOURCE_DIR}/swig/swig_inc.i
)

# SWIG flags
set(CMAKE_SWIG_FLAGS -py3 -keyword) # Use -keyword option to activate kwargs
# Note: Cannot use -doxygen feature because all documentation is in C++ body files
# Note: Use -E option for seeing SWIG preprocessor output

# SWIG target (generate wrapper & python script then build [so,pyd] library)
swig_add_library(
  python_build
  LANGUAGE   python
  TYPE       SHARED
  SOURCES    ${SRC}
)

if (APPLE)
  # To prevent 'import' from crashing under Mac (swig output suffix is .dynlib by default) 
  set_target_properties(python_build PROPERTIES SUFFIX ".so")
endif()

# Link to static library and NumPy headers
target_link_libraries(python_build PUBLIC ${PROJECT_NAME}::static Python3::NumPy)

# Transmit the fact that we are linking to static ${PROJECT_NAME} library
set(COMP_FLAGS "-D${PROJECT_NAME_UP}_STATIC_DEFINE")
if (MSVC)
  set(COMP_FLAGS "${COMP_FLAGS} /wd4706 /wd4456 /wd4127") # SWIG generated code warnings
endif()
if ("${FLAVOR}" STREQUAL "Debug")
  set(COMP_FLAGS "${COMP_FLAGS} -g")
endif()

# Set some properties on SWIG target
set_target_properties(python_build PROPERTIES
  # Do not build python package by default
  EXCLUDE_FROM_ALL ON
  # Modify the generated library name
  OUTPUT_NAME ${PROJECT_NAME}
  # Compiler flags for the SWIG library
  COMPILE_FLAGS ${COMP_FLAGS}
)

# Find appropriate Python.h
target_include_directories(python_build PRIVATE ${Python3_INCLUDE_DIRS})

# Link to python's libraries (needed for MSVC and MacOS)
# Prefer using Python3::Module (which works for MacOS) in place of ${Python3_LIBRARIES}
# https://gitlab.kitware.com/cmake/cmake/-/issues/17664
target_link_libraries(python_build PRIVATE Python3::Module)


########################################
# PACKAGING (target independent)

# Generate setup.py automatically for each configuration
# First step: replace variables (@VAR@)
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/setup.py.in 
  ${CMAKE_CURRENT_BINARY_DIR}/setup.py.in
  @ONLY
)

# Second step: replace generator expression ($<>)
file(GENERATE
  OUTPUT ${PYTHON_PACKAGE_ROOT_FOLDER}/setup.py
  INPUT ${CMAKE_CURRENT_BINARY_DIR}/setup.py.in
)

# Generate README.md for each configuration
file(GENERATE
  OUTPUT ${PYTHON_PACKAGE_ROOT_FOLDER}/README.md
  INPUT  ${CMAKE_CURRENT_SOURCE_DIR}/README.md
)

######################################
# INSTALLATION

# Add a custom target for python package installation
# TODO: Do also installation each time setup.py.in or README.md is modified
add_custom_target(python_install
  COMMAND ${Python3_EXECUTABLE} -m pip install ${PYTHON_PACKAGE_ROOT_FOLDER}
  COMMENT "Installing python package"
  VERBATIM
)

# Tell to CMake that python package must be built before installation [python_doc is optional]
add_dependencies(python_install python_build)

