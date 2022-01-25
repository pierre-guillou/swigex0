# Only shared library is installed
if(NOT BUILD_SHARED)
  return()
endif()

# Default GNU installed directory names
include(GNUInstallDirs)

####################################################
## INSTALLATION

# Install the shared library in DESTINATION/lib folder
install(TARGETS shared
  EXPORT ${PROJECT_NAME}_corelibs
  LIBRARY DESTINATION lib
)

# Include directories
target_include_directories(shared PUBLIC
  # Installed includes are made PUBLIC for client who links the shared library
  $<INSTALL_INTERFACE:include>
)

# Install the includes
install(
  DIRECTORY ${INCLUDES}/              # Install library headers
  DESTINATION include/${PROJECT_NAME} # in DESTINATION/include/${PROJECT_NAME}
)

# Install the version file
install(
  FILES ${PROJECT_BINARY_DIR}/version.h
  DESTINATION include/${PROJECT_NAME}
)

# Export the shared library cmake configuration (See above for corelibs definition)
install(
  EXPORT ${PROJECT_NAME}_corelibs
  FILE ${PROJECT_NAME}Config.cmake
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake
)

####################################################
## UNINSTALLATION

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
