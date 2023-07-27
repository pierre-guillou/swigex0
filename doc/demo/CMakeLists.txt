# Add 'build_demos' target for processing all demo scripts
add_custom_target(build_demos)

add_custom_target(print_startup_demos
                  COMMAND ${CMAKE_COMMAND} -E echo "Executing all demonstration scripts...")

# WARNING: The BUILD_DEP must not be null to work
set(BUILD_DEP print_startup_demos)

if (BUILD_PYTHON)
  add_subdirectory(python)
  list(APPEND BUILD_DEP build_demos_py)
endif()

if (BUILD_R)
  add_subdirectory(r)
  list(APPEND BUILD_DEP build_demos_r)
endif()

if (NOT BUILD_DEP STREQUAL "")
  add_dependencies(build_demos ${BUILD_DEP})
endif()

