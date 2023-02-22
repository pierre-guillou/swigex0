# swigex C++ Library and Wrappers

* Author: Fabien Ors (MINES PARIS - PSL University) 
* Date: Feb. 2023

Example of a cross-platform C++ library exported in Python and R using SWIG and CMake. Following features are tested:
* Non regression tests in C++, Python and R (using CTest and automatic github actions)
* Python and R packages local installation through CMake
* Python and R packages deployment on TestPyPi and CRAN (not yet available) (using manual github actions)
* Simple C++ class export (see testFibo)
* Special classes for handling *vectors* and *numerical vectors* based on std::vector (see VectorT.hpp and VectorNumT.hpp) which permits to:
  * Extend std::vector capabilities (stream, numerical operators,...)
  * Handle *undefined values* of any types
* Use of typemaps for testing *arguments* wrapping (see testArgs):
  * For C++ types: int, double, std::string, Vector\*, VectorVector\*
  * Passed by input value, input reference, input pointers and output pointers
  * Possibly having C++ default values (argument naming is not yet possible in R)
* *Inheritance* in target language (see testPolymorph) (still in development)

* C++ Vector\* class is converted:

|        | from C++    | to C++                   |
|--------|-------------|--------------------------|
| Python | numpy.array | tuple, list, numpy.array |
| R      | vector      | vector, list             |

* C++ VectorVector\* class is converted:

|        | from C++                    | to C++                                               |
|--------|-----------------------------|------------------------------------------------------|
| Python | numpy.array of numpy.arrays | list or numpy.array of tuples, lists or numpy.arrays |
| R      | list of vectors             | list of vectors                                      |
  
A lot of CMake and SWIG instructions in this project have been used to solve issues I encountered. There certainly exist smarter and simpler ways to accomplish all the stuff. Feel free to suggest any simplifications in order to make swigex as simple as possible!

Look for 'TODO' keyword for remaining issues.

## Prerequisites

This library has been successfully tested with Ubuntu 16/18/20 LTS and Windows 10 (MacOS: not tested).

For compiling and installing *swigex* C++ Library, the following tools must be available (See [required tools installation](#required-tools-installation) instructions below):

* Git client
* CMake tool 3.20 or higher
* A C++ compiler:
  * Linux:
    * GCC compiler 5.4 or higher
  * Windows:
    * Microsoft Visual Studio C++ 14 or higher
    * MinGW 7 or higher (we propose the one provided with RTools)
  * MacOS (not tested):
    * Clang 12 or higher

The following tools must be available for compiling and installing Python package:
* SWIG 4 or higher
* Python 3 or higher with *pip* and *numpy* modules installed

The following tools must be available for compiling and installing R package:
* SWIG 4.2.0 **customized by Fabien Ors** (not the official version!)
* R 4 or higher
* RTools 4 for Windows user

See [required tools installation](#required-tools-installation) instructions below.

## Get the sources

For getting the sources files, just clone the github repository:

    git clone https://github.com/fabien-ors/swigex
    cd swigex

Notes:

* In the following, all instructions must be executed from a command prompt inside this *root* directory (thus the last command `cd swigex` above)

## Usage

The objective of this package is to provide an example of wrapping a C++ library in R and Python using CMake and SWIG. Derivative usage instructions will come soon.

Note: See shortcuts for 'make' users in *Makefile* file

### Configure project
Depending on the package you want to build you must adapt the command below:
#### GCC / MinGW / CLang
    cmake -Bbuild -H. -DCMAKE_BUILD_TYPE=Release -DBUILD_PYTHON=ON -DBUILD_R=ON
#### MSVC (Visual)
    cmake -Bbuild -H. -DBUILD_PYTHON=ON -DBUILD_R=ON

### Important Notes

* Using MingGW on a Windows where Visual Studio is also installed may need to add `-G "MSYS Makefiles"` in the command above.
* The default installation directory named *swigex_install* is located in your *Home*. If you want to change it, you can either:
    * Define the `swigex_INSTALL_DIR` environment variable or
    * Add `-Dswigex_INSTALL_DIR=<path/of/swigex/install/dir>` to the first cmake command above
* If you want to build and install the *Debug* version, you must replace `Release` by `Debug` above (GCC/MinGW) and below (MSVC)
* The *static* version of the library is mandatory for creating Python and R packages
* Only the *shared* library (built by default) is installed by the 'install' target

### Build static library (and install Python package)
#### GCC / MinGW / CLang
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

Depending on the package you want to build, all dependencies are not mandatory (R and Python)

### Linux (Ubuntu)

1. (For R users only) - Remove any previous installation of SWIG (if any)

2. Then, execute the following commands:

````
sudo apt install git
sudo apt install cmake
sudo apt install r-base
sudo apt install python3
sudo apt install python3-pip
sudo apt install bison
sudo apt install pcre2-devel # Ubuntu 18
sudo apt install libpcre2-dev # Ubuntu 20
python3 -m ensurepip --upgrade
python3 -m pip install numpy
````

3. In a folder of your own, compile and install SWIG 4.2.0 [customized] by executing following commands:

````
git clone https://github.com/fabien-ors/swig.git
cd swig
cmake -Bbuild
cd build
make
sudo make install
````

Notes:

* If you don't have sudo permissions, you may have to install swig in a folder of your choice. In that case, use `-DCMAKE_INSTALL_PREFIX:PATH=/home/user/Programs` (adapt installation folder) in the `cmake` command above.
* Under Linux, the GCC compiler and GNU make is already installed
* If your Linux distribution repositories don't provide minimum required versions, please install the tools manually (see provider website)

### MacOS

1. (For R users only) - Remove any previous installation of SWIG (if any)

2. Then, execute the following commands (Not tested):

````
brew install git
brew install cmake
brew install r
brew install bison
brew install pcre2-devel
brew install python3
python3 -m ensurepip --upgrade
python3 -m pip install numpy
````

3. In a folder of your own, compile and install SWIG 4.2.0 [customized] by executing following commands:

````
git clone https://github.com/fabien-ors/swig.git
cd swig
cmake -Bbuild
cd build
make
sudo make install
````

Notes:

* If you don't have sudo permissions, you may have to install swig in a folder of your choice. In that case, use `-DCMAKE_INSTALL_PREFIX:PATH=/home/user/Programs`  (adapt installation folder) in the `cmake` command above.
* Under MacOS, the GCC (or Clang) compiler and GNU make is already installed
* If your MacOS repositories don't provide minimum required versions, please install the tools manually (see provider website)
  
### Windows - Microsoft Visual Studio

These requirements are also recommended to people who wants to compile *swigex* Python package. If you want to compile *swigex* R package under Windows, you should look at the next section.

1. Download and install the following tools using default options during installation:

* Git client [from here](https://gitforwindows.org) (*Setup program* [exe])
* CMake tool [from here](https://cmake.org/download) (*Windows Installer* [msi], check the *'Add CMake to the system PATH for all users'* option during installation)
* Microsoft Visual Studio (Community) [from here](https://visualstudio.microsoft.com/fr/thank-you-downloading-visual-studio/?sku=Community&channel=Release&version=VS2022&source=VSLandingPage&cid=2030&passive=false) (*VisualStudioSetup.exe* - only select the *Visual Studio Desktop C++* component)
* Python 3+ [from here](https://www.python.org/downloads) (*Windows installer* [exe] - check 'Add python.exe to PATH' in the first panel)
* SWIG 4+ [from here](http://www.swig.org/download.html) (*swigwin archive* [zip], Archive file [zip] to be extracted in a folder of your own - and remind that folder)

2. Then, install additional Python modules by running following instructions in a command prompt:

````
python -m pip install numpy
````

Notes:

* The *Path* environment variable (**System variables**) must be updated to make *swig.exe* available in the batch command line (follow [this guide](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10) to add *SWIG* installation folders in the *Path* variable and restart Windows)
* The Windows C++ Compiler used must be the same that the one used for compiling Python (Visual C++). Using another compiler than Visual C++ is not supported.
* You must restart your computer after installing these requirements

### Windows - MinGW (via RTools)

These requirements are also recommended to people who wants to compile *swigex* R package. If you want to compile *swigex* Python package under Windows, you should look at the previous section. This is not the only way to install MinGW. But using MinGW provided with RTools permits us to also handle *swigex* R package compilation.

#### Install R and RTools

Download and install the following tools using default option during installation:

* R [from here](https://cran.r-project.org/bin/windows/base) (*Setup program* [exe] - remind the installation folder, assume it is `C:\Program Files\R\R-4.2.2`)
* RTools [from here](https://cran.r-project.org/bin/windows/Rtools) (RTools *Installer* [exe] - remind the installation folder, assume it is `C:\rtools42`)

Notes:

* Choose the corresponding RTools version according to the R version installed
* Instructions in this section are **valid since R v4.2** (for older versions please contact us)
* RTools is not the unique way to install MinGW on Windows, but it is our preferred way as we can handle R packages compilation
* The *Path* environment variable (*System variables*) must be updated to make *R.exe* available in the batch command line (follow [this guide](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10) to add `bin` directory from the *R* installation folder in the *Path* variable and restart Windows, ie: `C:\Program Files\R\R-4.2.2\bin`)

#### Add MSYS2 Required Packages

1. Edit the `etc/pacman.conf` file in the RTools installation directory (ie: `C:\rtools42`) by changing the `SigLevel` variable to `Never` (otherwise, *git* cannot be installed using *pacman*):

````
SigLevel=Never
````

2. Edit the `mingw64.ini` file in the RTools installation directory (ie: `C:\rtools42`) by un-commenting the following line (remove '#' character at the beginning):

````
MSYS2_PATH_TYPE=inherit
````

3. Launch *mingw64.exe* in RTools installation directory (ie: `C:\rtools42`) and pin the icon to the task bar

4. From the *mingw64* shell command prompt, execute following instructions:

````
pacman -Sy git
pacman -Sy mingw-w64-x86_64-cmake
pacman -Sy mingw-w64-x86_64-gcc
pacman -Sy bison
pacman -Sy mingw-w64-x86_64-pcre2
````

#### Install customized SWIG 4.2.0

In a directory of your own, compile and install SWIG 4.2.0 [customized] by executing following commands from the *mingw64* shell command prompt:

````
git clone https://github.com/fabien-ors/swig.git
cd swig
cmake -G "MSYS Makefiles" -Bbuild -DCMAKE_INSTALL_PREFIX:PATH=/mingw64/
cd build
make
make install
````

## Known caveats

If you experience the following error while importing *swigex* Package under Python:

    RuntimeError: module compiled against API version 0x10 but this version of numpy is 0xe

... you may need to upgrade numpy:

    python -m pip install --upgrade numpy

---

## License
MIT
2022 Fabien Ors
