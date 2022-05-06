if(NOT BUILD_R)
  return()
endif()

# R package name
set(R_PACKAGE_NAME ${PROJECT_NAME})
# Beware : the real package name is the PROJECT_NAME (for better import)

# Create the global target for building R package
add_custom_target(r_build_package)

###################################
# DEPENDENCIES

# Look for R
include(${PROJECT_SOURCE_DIR}/cmake/FindR.cmake)

# Look for SWIG 4
find_package(SWIG 4.0 REQUIRED)
# TODO : If SWIG not found, fetch it from the web
include(${SWIG_USE_FILE})

######################################
# WRAPPER GENERATION & BUILD

# R package target
set(RTGT r_build)

# R package interface file
set(SRC rfibo.i)

# Generation folders
if (MSVC) # TODO: Prefer using GENERATOR_IS_MULTI_CONFIG
  set(R_PACKAGE_ROOT_FOLDER        ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>)
else()
  set(R_PACKAGE_ROOT_FOLDER        ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE})
endif()
set(R_PACKAGE_DESTINATION_FOLDER ${R_PACKAGE_ROOT_FOLDER}/${R_PACKAGE_NAME})
set(R_PACKAGE_R_FOLDER           ${R_PACKAGE_DESTINATION_FOLDER}/R)
#file(MAKE_DIRECTORY ${R_PACKAGE_DESTINATION_FOLDER})

# Location for SWIG target language code
set(CMAKE_SWIG_OUTDIR                 ${R_PACKAGE_R_FOLDER})
# Location for SWIG wrapper library
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY    ${R_PACKAGE_R_FOLDER}) # Use LIBRARY (gcc)!
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY    ${R_PACKAGE_R_FOLDER}) # Use RUNTIME (msvc)!

# SWIG interface source file properties
set_source_files_properties(${SRC} PROPERTIES
  CPLUSPLUS ON
  # Swig wrapper will be regenerated if C++ headers are changed
  # https://stackoverflow.com/a/70375654/3952924
  USE_SWIG_DEPENDENCIES TRUE
  # myfibo C++ headers will be found by %import directive
  USE_TARGET_INCLUDE_DIRECTORIES TRUE
)

# Tell to CMake that ${SRC} depends on some other files
# TODO: This only works on GCC because MSVC always recompile swig (don't know why)
set_property(SOURCE ${SRC} PROPERTY
  DEPENDS
    ${PROJECT_SOURCE_DIR}/swig/swig_exp.i
    ${PROJECT_SOURCE_DIR}/swig/swig_inc.i
)

# SWIG flags
#set(CMAKE_SWIG_FLAGS)
# Note: Cannot use -doxygen feature because all documentation is in C++ body files
# Note: Use -E option for seeing SWIG preprocessor output

# SWIG target (generate wrapper & R script then build [so,dll] library)
swig_add_library(
  ${RTGT}
  LANGUAGE   r
  TYPE       SHARED
  SOURCES    ${SRC}
)

# Link to static library
target_link_libraries(${RTGT} PUBLIC ${PROJECT_NAME}::static)

# Transmit the fact that we are linking to static ${PROJECT_NAME} library
set(COMP_FLAGS "-D${PROJECT_NAME_UP}_STATIC_DEFINE")
# Set some properties on SWIG target
set_target_properties(${RTGT} PROPERTIES
  # Do not build R package by default
  EXCLUDE_FROM_ALL ON
  # Modify the generated library name
  OUTPUT_NAME ${PROJECT_NAME}
  # Compiler flags for the SWIG library
  COMPILE_FLAGS ${COMP_FLAGS}
)

# Find appropriate R.h
target_include_directories(${RTGT} PRIVATE ${R_INCLUDE_DIRS})

# Link to R's libraries (only for Windows - Release)
if(WIN32)
  target_link_libraries(${RTGT} PRIVATE ${R_LIBRARIES})
endif()

if(APPLE)
  target_link_libraries(${RTGT} PRIVATE ${R_LIBRARIES})
endif()

# Add SWIG target to global R build package dependency
add_dependencies(r_build_package ${RTGT})

########################################
# PACKAGING (target independent)

# Generate DESCRIPTION automatically for each configuration
# First step: replace variables (@VAR@)
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/DESCRIPTION.in 
  ${CMAKE_CURRENT_BINARY_DIR}/DESCRIPTION.in
  @ONLY
)
# Second step: replace generator expression ($<>)
file(GENERATE
  OUTPUT ${R_PACKAGE_DESTINATION_FOLDER}/DESCRIPTION
  INPUT ${CMAKE_CURRENT_BINARY_DIR}/DESCRIPTION.in
)

# Generate NAMESPACE automatically for each configuration
# First step: replace variables (@VAR@)
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/NAMESPACE.in 
  ${CMAKE_CURRENT_BINARY_DIR}/NAMESPACE.in
  @ONLY
)
# Second step: replace generator expression ($<>)
file(GENERATE
  OUTPUT ${R_PACKAGE_DESTINATION_FOLDER}/NAMESPACE
  INPUT ${CMAKE_CURRENT_BINARY_DIR}/NAMESPACE.in
)

# Generate README.md for each configuration
file(GENERATE
  OUTPUT ${R_PACKAGE_DESTINATION_FOLDER}/README.md
  INPUT  ${CMAKE_CURRENT_SOURCE_DIR}/README.md
)


######################################
# INSTALLATION (not tested)

# Add a custom target for R package installation
# TODO: Do also installation each time DESCRIPTION.in or README.md is modified
#add_custom_target(r_install
#  COMMAND ${R_EXECUTABLE} CMD INSTALL --preclean --clean ${R_PACKAGE_ROOT_FOLDER}
#  COMMENT "Installing R package"
#  VERBATIM
#)
add_custom_target(r_install
  COMMAND ${CMAKE_COMMAND} -E echo Nothing to do currently
  COMMENT "Installing R package"
  VERBATIM
)

# Tell cmake that r package must be built before installation
add_dependencies(r_install r_build_package)


