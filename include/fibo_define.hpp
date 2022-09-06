#pragma once

#include <string>
#include <iostream>
typedef std::string String;

#define DEFAULT_TITLE "Fibonacci List"

#define INT_NA    -999
#define DOUBLE_NA -999.999
#define STRING_NA "NA"

template<typename T> class ValueNA;

// Define NA value for int
template <> class ValueNA<int>
{
public:
    static inline int getNA() { return INT_NA; }
};

// Define NA value for double
template <> class ValueNA<double>
{
public:
  static inline double getNA() { return DOUBLE_NA; }
};

// Define NA value for String
template <> class ValueNA<String>
{
public:
  static inline String getNA() { return STRING_NA; }
};

template <typename T> inline T    getNAValue()     { return ValueNA<T>::getNA(); }
template <typename T> inline bool isNA(const T& v) {
  //std::cout << "isNA called with " << v << std::endl;
  return (v == ValueNA<T>::getNA());
}
