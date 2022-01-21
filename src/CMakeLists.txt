# C++ includes path
set(INCLUDES ${CMAKE_CURRENT_SOURCE_DIR}/../include)

# Only static library (from now)
add_library(myfibo STATIC fibo.cpp)

# Include directories
target_include_directories(myfibo
  PUBLIC
    # Includes for compiling the library
    $<BUILD_INTERFACE: ${INCLUDES}>
    # Installed includes are made PUBLIC for client who links the library
    $<INSTALL_INTERFACE:include>
)

# Hide all by default
set_target_properties(myfibo
  PROPERTIES
    C_VISIBILITY_PRESET hidden
    CXX_VISIBILITY_PRESET hidden
)

# Any client who links the library needs -fPIC
set_property(TARGET myfibo PROPERTY POSITION_INDEPENDENT_CODE 1)

# Install the library in DESTINATION/lib folder
install(TARGETS myfibo EXPORT corelibs
        ARCHIVE DESTINATION lib
)

# Install the includes
install(DIRECTORY ${INCLUDES}/     # Install library includes
        DESTINATION include/myfibo # in DESTINATION/include/myfibo
)

