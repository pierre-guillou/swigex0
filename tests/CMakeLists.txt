# Add 'build_tests' target for building all tests executable
add_custom_target(build_tests)

# Add 'check' target for building then running the tests
add_custom_target(check)

# Define ctest command # TODO : really needed ? (yaml use --target check)
if (MSVC) # TODO use IS_MULTI_CONFIG
  # Need configuration to be tested
#  set(MY_CTEST_COMMAND ${CMAKE_CTEST_COMMAND} --verbose -C $<CONFIG>)
  set(MY_CTEST_COMMAND ${CMAKE_CTEST_COMMAND} -C $<CONFIG> --output-on-failure)
else()
#  set(MY_CTEST_COMMAND ${CMAKE_CTEST_COMMAND} --verbose)
  set(MY_CTEST_COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure)
endif()

# TODO : tests are executed for each directory but mixed
# TODO : reports are separated

add_subdirectory(cpp)
set(CHECK_DEP check_cpp)

if (BUILD_PYTHON)
  add_subdirectory(py)
  list(APPEND CHECK_DEP check_py)
endif()

if (BUILD_R)
  add_subdirectory(r)
  list(APPEND CHECK_DEP check_r)
endif()

add_dependencies(check ${CHECK_DEP})
