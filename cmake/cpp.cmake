# C++ code location
set(INCLUDES ${PROJECT_SOURCE_DIR}/include)
set(SOURCES ${PROJECT_SOURCE_DIR}/src/fibo.cpp)

# Generation folder
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE})

# Impose 'd' suffix in debug (global property)
set(CMAKE_DEBUG_POSTFIX d)

# Shared library if needed
set(FLAVORS)
if (BUILD_SHARED)
  add_library(shared SHARED ${SOURCES})
  set(FLAVORS ${FLAVORS} shared)
endif()
  
# static library if needed
if (BUILD_STATIC)
  add_library(static STATIC ${SOURCES})
  set(FLAVORS ${FLAVORS} static)
endif()

############################## Loop on flavors
foreach(FLAVOR ${FLAVORS})
  # Convert flavor to uppercase
  string(TOUPPER ${FLAVOR} FLAVOR_UP)

  # Alias target for a better name
  add_library(${PROJECT_NAME}::${FLAVOR} ALIAS ${FLAVOR})

  # Include directories
  target_include_directories(${FLAVOR} PUBLIC
    # Includes for compiling the library
    $<BUILD_INTERFACE: ${INCLUDES}>
    # Add binary directory to find generated version.h
    $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>
  )

  # Set some target properties
  set_target_properties(${FLAVOR} PROPERTIES
    # Symbol for export.hpp header (do not use GenerateExportHeader)
    COMPILE_FLAGS "-D${PROJECT_NAME_UP}_BUILD_${FLAVOR_UP}"
    # Hide all symbols by default (impose same behavior between Linux and Windows)
    C_VISIBILITY_PRESET hidden
    CXX_VISIBILITY_PRESET hidden
    # Any client who links the library needs -fPIC (static or shared)
    POSITION_INDEPENDENT_CODE 1
  )

  # Rename the output library name
  set_target_properties(${FLAVOR} PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
  
  # Set library version
  set_target_properties(${FLAVOR} PROPERTIES VERSION ${PROJECT_VERSION})
  
endforeach(FLAVOR ${FLAVORS})
############################## End loop on flavor
  
# Shared library specific options
if (BUILD_SHARED)
  # Set the so version to project major version
  set_target_properties(shared PROPERTIES
    SOVERSION ${PROJECT_VERSION_MAJOR}
  )
endif()

