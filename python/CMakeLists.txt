# Look for Python3
find_package(Python3 REQUIRED COMPONENTS Interpreter Development.Module)

# Look for SWIG 4
find_package(SWIG 4.0 REQUIRED)
include(${SWIG_USE_FILE})

# TODO : create 'python' target (EXCLUDE_FROM_ALL)

# Interface file
set(SRC fibo.i) 
# Keep sync with interface file content
# TODO : Generate automatically fibo.i ?
set(PYTHON_PACKAGE_NAME myfibopy)
# Generation folders
if (MSVC) # TODO: Prefer using GENERATOR_IS_MULTI_CONFIG
  set(PYTHON_PACKAGE_ROOT_FOLDER        ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>)
else()
  set(PYTHON_PACKAGE_ROOT_FOLDER        ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE})
endif()
set(PYTHON_PACKAGE_DESTINATION_FOLDER ${PYTHON_PACKAGE_ROOT_FOLDER}/${PYTHON_PACKAGE_NAME})
# Location for SWIG target language code
set(CMAKE_SWIG_OUTDIR                 ${PYTHON_PACKAGE_DESTINATION_FOLDER})
# Location for SWIG wrapper library
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY    ${PYTHON_PACKAGE_DESTINATION_FOLDER}) # Use LIBRARY (gcc)!
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY    ${PYTHON_PACKAGE_DESTINATION_FOLDER}) # Use RUNTIME (msvc)!

# SWIG interface source file
set_source_files_properties(${SRC} PROPERTIES
  CPLUSPLUS ON
  # Swig wrapper will be regenerated if C++ headers are changed
  # https://stackoverflow.com/a/70375654/3952924
  #USE_SWIG_DEPENDENCIES TRUE   # TODO : Incompatible with CMAKE_SWIG_OUTDIR under cmake 3.22 (MSVC)
  # myfibo C++ headers will be found by %import directive
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
set(CMAKE_SWIG_FLAGS -py3 -keyword)
# Note: Cannot use -doxygen feature because all documentation is in C++ body files
# Note: Use -E option for seeing SWIG preprocessor output

# SWIG target (generate wrapper then _myfibopy.[so,pyd] and myfibopy.py)
swig_add_library(
  ${PYTHON_PACKAGE_NAME}
  LANGUAGE   python
  TYPE       SHARED
  SOURCES    ${SRC}
)

# Link to static ${PROJECT_NAME} library
target_link_libraries(${PYTHON_PACKAGE_NAME} PUBLIC ${PROJECT_NAME}::static)
# Transmit the fact that we are linking to static ${PROJECT_NAME} library
set_target_properties(${PYTHON_PACKAGE_NAME} PROPERTIES COMPILE_FLAGS -D${PROJECT_NAME_UP}_STATIC_DEFINE)

# Find appropriate Python.h
target_include_directories(${PYTHON_PACKAGE_NAME} PRIVATE ${Python3_INCLUDE_DIRS})

# Link to python's libraries (only for MSVC - Release)
if(MSVC)
  target_link_libraries(${PYTHON_PACKAGE_NAME} PRIVATE ${Python3_LIBRARIES})
endif()

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

# Install python package (if SWIG target has run)
# TODO: Do also installation each time setup.py.in or README.md is modified
add_custom_command(TARGET ${PYTHON_PACKAGE_NAME}
  COMMAND ${Python3_EXECUTABLE} -m pip install ${PYTHON_PACKAGE_ROOT_FOLDER}
  COMMENT "Installing python package"
  VERBATIM
)

