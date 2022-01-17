
set(INCLUDES ${CMAKE_CURRENT_SOURCE_DIR}/../include)

add_library(myfibo STATIC fibo.cpp)
target_include_directories(myfibo
  PUBLIC
    # Includes for compiling the library
    $<BUILD_INTERFACE: ${INCLUDES}>
    # Installed includes for client who links the library
    $<INSTALL_INTERFACE:include>
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

