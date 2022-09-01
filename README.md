# MYFIBO C++ Library and Wrappers

* Author: Fabien Ors (MINES PARIS - PSL) 
* License: MIT
* Date: Sept. 2022

Example of a C++ library exported in R and python using SWIG and CMake

This library has been successfully tested with Ubuntu 16/18/20 LTS and Windows 10 (MacOS: not tested).

For compiling and installing *myfibo* C++ Library, the following tools must be available (See [required tools installation](#required-tools-installation) instructions below):

* Git client
* CMake tool 3.20 or higher
* A C++ compiler:
  * Linux/MacOS:
    * GCC compiler 5.4 or higher
  * Windows:
    * Microsoft Visual Studio C++ 14 or higher
    * MinGW 7 or higher (we propose the one provided with RTools)
  * MacOS (not tested):
    * Clang 12 or higher

The following tools must be available for compiling and installing python package:
* SWIG 4 or higher
* Python 3 or higher with *pip*, *numpy* and *pybind11* modules installed


See [required tools installation](#required-tools-installation) instructions below

## Get the sources

For getting the sources files, just clone the github repository:

    git clone https://github.com/myfibo/myfibo.git
    cd myfibo

Notes:

* In the following, all instructions must be executed from a command prompt inside this *root* directory (thus the last command `cd myfibo` above)

## Usage

The objective of this package is to provide an example of wrapping a C++ library in R and Python using CMake and Swig. Derivative usage instructions will come soon.

Note: See shortcuts for 'make' users in Makefile file

### Configure project
#### GCC / MinGW
    cmake -Bbuild -H. -DCMAKE_BUILD_TYPE=Release
#### MSVC (Visual)
    cmake -Bbuild -H.

### Important Notes

* Using MingGW on a Windows where Visual Studio is also installed may need to add `-G "MSYS Makefiles"` in the command above.
* The default installation directory named *myfibo_install* is located in your *Home*. If you want to change it, you can either:
    * Define the `MYFIBO_INSTALL_DIR` environment variable or
    * Add `-DMYFIBO_INSTALL_DIR=<path/of/myfibo/install/dir>` to the first cmake command above
* If you want to build and install the *Debug* version, you must replace `Release` by `Debug` above (GCC/MinGW) and below (MSVC)
* The *static* version of the library is mandatory for creating [python package]
* Only the *shared* library (built by default) is installed.

### Build static library (and install Python package)
#### GCC / MinGW
    cmake --build build --target python_install
#### MSVC (Visual)
    cmake --build build --target python_install --config Release

### Build static library (and install R package)
#### GCC / MinGW / CLang
    cmake --build build --target r_install
#### MSVC (Visual)
    cmake --build build --target r_install --config Release

### Build and install shared library (and don't build Python and R packages)
#### GCC / MinGW / CLang
    cmake --build build --target install
#### MSVC (Visual)
    cmake --build build --target install --config Release

### Execute non-regression tests (C++, Python and R when relevant)
#### GCC / MinGW / CLang
    cmake --build build --target check
##### MSVC (Visual)
    cmake --build build --target check --config Release

## Required tools installation

### Linux (Ubuntu):

    sudo apt install git
    sudo apt install cmake
    sudo apt install python3
    sudo apt install python3-pip
    sudo apt install swig
    python3 -m ensurepip --upgrade
    python3 -m pip install pybind11 numpy

Notes:

* Under Linux, the GCC compiler and GNU make is already installed
* If your Linux distribution repositories don't provide minimum required versions, please install the tools manually (see provider website)
* According your Linux distribution you may have to replace `pybind11` by the quoted string `"pybind11[global]"`

### MacOS:

    brew install git
    brew install cmake
    brew install python3
    brew install swig
    python3 -m ensurepip --upgrade
    python3 -m pip install pybind11 numpy
    
Notes:

* Under MacOS, the GCC (or Clang) compiler and GNU make is already installed
* If your MacOS repositories don't provide minimum required versions, please install the tools manually (see provider website)
  
### Windows:

Download and install the following tools:

* Git client [from here](https://gitforwindows.org) (Use default options during installation)
* CMake tool [from here](https://cmake.org/download) (Check the 'Add CMake to the Path' option during installation)
* Python 3+ [from here](https://www.python.org/downloads) (which comes with pip and which is installed in *C:\\Python39* for example)
* SWIG 4+ [from here](http://www.swig.org/download.html) (extract the archive in a directory of yours, let's say *C:\\swigwin-4.0.2*, see Notes below)
* Pybind11 and numpy python modules by running following instruction in a command prompt:

    python -m pip install "pybind11[global]" numpy
    
Notes:

* You must restart your computer after installing these requirements
* The *Path* environment variable must be updated to make *swig.exe* (and *python.exe*) available in the batch command line (follow [this guide](https://stackoverflow.com/questions/44272416/how-to-add-a-folder-to-path-environment-variable-in-windows-10-with-screensho) to add *C:\\swigwin-4.0.2* and *C:\\Python39* folder in the *Path* variable and restart Windows)
* The Windows C++ Compiler used must be the same that the one used for compiling Python (Visual C++). Using another compiler than Visual C++ is not supported.

#### Microsoft Visual Studio

Download and install the following tools:

* Microsoft Visual Studio C++ 14+ [from here](https://visualstudio.microsoft.com/fr/vs/features/cplusplus/)

#### MingGW (RTools)

Download and install the following tools:

* R 4 or higher [from here](https://cran.r-project.org)
* RTools 4 [from here](https://cran.r-project.org/bin/windows/Rtools/rtools40.html)
  
Notes:

* You must restart your computer after installing these requirements
* RTools is not the unique way to install MinGW on Windows, but it is our preferred way as we can handle R packages compilation
