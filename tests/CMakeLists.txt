# Add 'build_tests' target for building all tests executable
add_custom_target(build_tests)

# Add 'check' target for building then running the tests
add_custom_target(check)

# Define ctest command
if (MSVC) # TODO use IS_MULTI_CONFIG
  # Need configuration to be tested
#  set(MY_CTEST_COMMAND ${CMAKE_CTEST_COMMAND} --verbose -C $<CONFIG>)
  set(MY_CTEST_COMMAND ${CMAKE_CTEST_COMMAND} -C $<CONFIG> --output-on-failure)
else()
#  set(MY_CTEST_COMMAND ${CMAKE_CTEST_COMMAND} --verbose)
  set(MY_CTEST_COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure)
endif()

add_subdirectory(cpp)
#add_subdirectory(py)
#add_subdirectory(r)

# TODO : tests are executed for each directory but mixed
# TODO : reports are separated
#add_dependencies(check check_cpp check_py check_r)
add_dependencies(check check_cpp)
