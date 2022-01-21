# C++ includes path
set(INCLUDES ${CMAKE_CURRENT_SOURCE_DIR}/../include)

# Generation folder
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE})
  
# Only static library (from now)
add_library(myfibo STATIC fibo.cpp)

# Include directories
target_include_directories(myfibo PUBLIC
  # Includes for compiling the library
  $<BUILD_INTERFACE: ${INCLUDES}>
  # Installed includes are made PUBLIC for client who links the library
  $<INSTALL_INTERFACE:include>
)

# Set some target properties
set_target_properties(myfibo PROPERTIES
  # Hide all symbols by default
  C_VISIBILITY_PRESET hidden
  CXX_VISIBILITY_PRESET hidden
  # Any client who links the library needs -fPIC
  POSITION_INDEPENDENT_CODE 1
)

# Install the library in DESTINATION/lib folder
install(TARGETS myfibo
  EXPORT corelibs
  ARCHIVE DESTINATION lib
)

# Install the includes
install(
  DIRECTORY ${INCLUDES}/     # Install library headers
  DESTINATION include/myfibo # in DESTINATION/include/myfibo
)

