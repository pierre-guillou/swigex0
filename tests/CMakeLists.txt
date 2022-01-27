# Global target (for building all tests)
add_custom_target(build_tests)

# Test sources
set(TEST_SOURCES main.cpp)

# Generation folders
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE})

# Compile each test executable
set(TARGETS_EXE "")
foreach(TEST_SOURCE_FILE ${TEST_SOURCES})
  # Retrieve source file name without extension (will become executable name)
  get_filename_component(TEST_NAME ${TEST_SOURCE_FILE} NAME_WE)
  # Add to executable targets list
  list(APPEND TARGETS_EXE ${TEST_NAME})
  # Define sources list for the target executable
  add_executable(${TEST_NAME} EXCLUDE_FROM_ALL ${TEST_SOURCE_FILE})
  # Link each test to shared library
  target_link_libraries(${TEST_NAME} PRIVATE ${PROJECT_NAME}::shared)
  # Trigger the build of the test with the target build_tests
  add_dependencies(build_tests ${TEST_NAME})
endforeach(TEST_SOURCE_FILE ${TEST_SOURCES})

# Display test output in case of failure
set(CTEST_OUTPUT_ON_FAILURE ON)

# Run each registered executable
foreach(TARGET_EXE ${TARGETS_EXE})
  # Add current test (to be run)
  add_test(NAME ${TARGET_EXE} COMMAND ${TARGET_EXE})
endforeach(TARGET_EXE ${TARGETS_EXE})

# Add 'check' target for building then running the tests executable
if (MSVC) # TODO use IS_MULTI_CONFIG
  # Need configuration to be tested
  set(MY_CTEST_COMMAND ${CMAKE_CTEST_COMMAND} -C $<CONFIG>)
else()
  set(MY_CTEST_COMMAND ${CMAKE_CTEST_COMMAND})
endif()
if (WIN32)
  # Need DLL location before running the test
  add_custom_target(check
    COMMAND set PATH=$<TARGET_FILE_DIR:${PROJECT_NAME}::shared>\;%PATH%  # Do not forget \; !!
    COMMAND ${MY_CTEST_COMMAND} DEPENDS ${TARGETS_EXE}
  )
else()
  add_custom_target(check
    COMMAND ${MY_CTEST_COMMAND} DEPENDS ${TARGETS_EXE}
  )
endif()



