# This Makefile is just a shortcut to cmake commands for Linux users only
#
# Call 'make' with one of this target:
# 
# C++ Library:
#  - shared         Build myfibo shared library
#  - static         Build myfibo static library
#  - build_tests    Build non-regression tests executables
#  - doxygen        Build doxygen documentation [optional] [TODO]
#  - install        Install myfibo shared library [and html doxymentation]
#  - uninstall      Uninstall myfibo shared library [and html doxymentation]
#
# Python wrapper:
#  - python_doc     Build python package documentation [optional] [TODO]
#  - python_build   Build python package [and its documentation]
#  - python_install Install python package [and its documentation]
#  - python_upload  Build python package distribution and upload to PyPi [and its documentation] [TODO]
#
# R wrapper:
#  - r_doc          Build R package documentation [optional] [TODO]
#  - r_build        Build R package [and its documentation]
#  - r_install      Install R package [and its documentation]
#  - r_upload       Build R package distribution and upload to CRAN-like [and its documentation] [TODO]
#
# No- regression tests:
#  - check_cpp      Execute non-regression tests (cpp)
#  - check_py       Execute non-regression tests (python)
#  - check_r        Execute non-regression tests (R)
#  - check          Execute non-regression tests (cpp + python + R)

# Clean:
#  - clean          Clean generated files
#  - clean_all      Clean the build directory

# You can use the following variables:
#
#  - DEBUG=1            Build the debug version of the library and tests (default =0)
#  - N_PROC=N           Use more CPUs for building procedure (default =1)
#  - BUILD_DIR=<path>   Define a specific build directory (default =build)
#

ifeq ($(DEBUG), 1)
  FLAVOR = Debug
 else
  FLAVOR = Release 
endif

ifndef BUILD_DIR
  BUILD_DIR = build
endif

ifdef N_PROC
  N_PROC_OPT = -j$(N_PROC)
endif

NO_PRINT_DIR = --no-print-directory
CONFIG = 
ifeq ($(OS),Windows_NT)
  NO_PRINT_DIR =
  CONFIG = --config $(FLAVOR)
endif

all: shared install

.PHONY: all cmake static shared build_tests doxygen install uninstall

cmake:
	@cmake -DCMAKE_BUILD_TYPE=$(FLAVOR) -B$(BUILD_DIR) -H.

static: cmake
	@cmake --build $(BUILD_DIR) --target static $(CONFIG) -- $(NO_PRINT_DIR) $(N_PROC_OPT)

shared: cmake
	@cmake --build $(BUILD_DIR) --target shared $(CONFIG) -- $(NO_PRINT_DIR) $(N_PROC_OPT)

build_tests: cmake
	@cmake --build $(BUILD_DIR) --target build_tests $(CONFIG) -- $(NO_PRINT_DIR) $(N_PROC_OPT)

doxygen: cmake
	@echo "Target doxygen not yet implemented"

install: cmake
	@cmake --build $(BUILD_DIR) --target install $(CONFIG) -- $(NO_PRINT_DIR) $(N_PROC_OPT)

uninstall: 
	@cmake --build $(BUILD_DIR) --target uninstall $(CONFIG) -- $(NO_PRINT_DIR) $(N_PROC_OPT)



.PHONY: python_doc python_build python_install python_upload

python_doc: cmake
	@echo "Target python_doc not yet implemented"

python_build: cmake
	@cmake --build $(BUILD_DIR) --target python_build $(CONFIG) -- $(NO_PRINT_DIR) $(N_PROC_OPT)

python_install: cmake
	@cmake --build $(BUILD_DIR) --target python_install $(CONFIG) -- $(NO_PRINT_DIR) $(N_PROC_OPT)

python_upload: cmake
	@echo "Target python_upload not yet implemented"



.PHONY: r_doc r_build r_install r_upload

r_doc: cmake
	@echo "Target r_doc not yet implemented"

r_build: cmake
	@cmake --build $(BUILD_DIR) --target r_build $(CONFIG) -- $(NO_PRINT_DIR) $(N_PROC_OPT)

r_install: cmake
	@cmake --build $(BUILD_DIR) --target r_install $(CONFIG) -- $(NO_PRINT_DIR) $(N_PROC_OPT)

r_upload: cmake
	@echo "Target r_upload not yet implemented"



.PHONY: check_cpp check_py check_r check

check_cpp: cmake
	@CTEST_OUTPUT_ON_FAILURE=1 cmake --build $(BUILD_DIR) $(CONFIG) --target check_cpp -- $(NO_PRINT_DIR) $(N_PROC_OPT)

check_py: cmake
	@CTEST_OUTPUT_ON_FAILURE=1 cmake --build $(BUILD_DIR) $(CONFIG) --target check_py -- $(NO_PRINT_DIR) $(N_PROC_OPT)

check_r: cmake
	@CTEST_OUTPUT_ON_FAILURE=1 cmake --build $(BUILD_DIR) $(CONFIG) --target check_r -- $(NO_PRINT_DIR) $(N_PROC_OPT)

check: cmake
	@CTEST_OUTPUT_ON_FAILURE=1 cmake --build $(BUILD_DIR) $(CONFIG) --target check -- $(NO_PRINT_DIR) $(N_PROC_OPT)



.PHONY: clean clean_all

clean: 
	@cmake --build $(BUILD_DIR) --target clean -- $(NO_PRINT_DIR) $(N_PROC_OPT)

clean_all:
	@rm -rf $(BUILD_DIR)

