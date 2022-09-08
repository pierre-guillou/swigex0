#pragma once

#include <string>
#include <iostream>
#include <cmath>
#include <math.h>
typedef std::string String;

#define DEFAULT_TITLE "Fibonacci List"

#ifndef SWIG

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

// Generic functions
template <typename T> inline T getNA()
{
  return ValueNA<T>::getNA();
}

template <typename T> inline bool isNA(const T& v);
template <> inline bool isNA(const double& v)
{
  return (std::isnan(v) || std::isinf(v) ||
          v == getNA<double>());
}
template <> inline bool isNA(const int& v)
{
  return (v == getNA<int>());
}
template <> inline bool isNA(const String& v)
{
  return (v == getNA<String>());
}

#endif // SWIG
