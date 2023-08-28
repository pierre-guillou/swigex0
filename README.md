# swigex C++ Library and Wrappers

* Author: Fabien Ors (MINES Paris - PSL University) 
* Date: May 2023

The *swigex* C++ library is a derivative work based on the *swigex0* project: [https://github.com/fabien-ors/swigex0](https://github.com/fabien-ors/swigex0)

*swigex* is an example of a cross-platform C++ library exported in Python and R using CMake and SWIG. **Additional following features** are tested:
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

Please, refer to *swigex0* project for more details: [https://github.com/fabien-ors/swigex0](https://github.com/fabien-ors/swigex0)

## Install

### Python Package
From a shell command prompt:

    pip install swigex

### R Package
From an R command prompt:

    install.package("swigex", repos="https://fabien-ors.github.io/drat/")

## Usage
This library implements a Fibonacci list C++ object exported to Python and R via SWIG using numerical vector class. Here is an example usage in Python:

    import swigex
    vec = swigex.Fibo(40).get()
    print("vec type is {}".format(type(vec)))


## Install from source

This library has been successfully tested with Ubuntu 16/18/20 LTS and Windows 10 (MacOS: not tested).

For installing from source, you must follow instructions from [https://github.com/fabien-ors/swigex0](https://github.com/fabien-ors/swigex0).

The only additional prerequisite is to have *numpy* package installed with your Python.

## Known caveats

If you experience the following error while importing *swigex* Package under Python:

    RuntimeError: module compiled against API version 0x10 but this version of numpy is 0xe

... you may need to upgrade numpy:

    python -m pip install --upgrade numpy

---

## License
MIT
2023 Fabien Ors
