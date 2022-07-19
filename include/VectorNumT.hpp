/******************************************************************************/
/* COPYRIGHT ARMINES, ALL RIGHTS RESERVED                                     */
/*                                                                            */
/* THE CONTENT OF THIS WORK CONTAINS CONFIDENTIAL AND PROPRIETARY             */
/* INFORMATION OF ARMINES. ANY DUPLICATION, MODIFICATION,                     */
/* DISTRIBUTION, OR DISCLOSURE IN ANY FORM, IN WHOLE, OR IN PART, IS STRICTLY */
/* PROHIBITED WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF ARMINES         */
/*                                                                            */
/* TAG_SOURCE_CG                                                              */
/******************************************************************************/
#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"

#include "VectorT.hpp"

#include <vector>
#include <sstream>
#include <memory>
#include <limits>
#include <algorithm>
#include <cmath>

/***************************************************************************
 **
 ** Vector of T values (numerical type).
 ** T type must define copy constructor and assignment operator
 ** T type must override numerical operators (+, -, *, /)
 **
 ***************************************************************************/
template <typename T>
class MYFIBO_EXPORT VectorNumT : public VectorT<T>
{
public:
  typedef VectorT<T> Parent;
  typedef std::vector<T> Vector;
  typedef typename Vector::value_type               value_type;
  typedef typename Vector::size_type                size_type;
  typedef typename Vector::iterator                 iterator;
  typedef typename Vector::const_iterator           const_iterator;
  typedef typename Vector::reverse_iterator         reverse_iterator;
  typedef typename Vector::const_reverse_iterator   const_reverse_iterator;

public:
  inline VectorNumT()                                              : Parent() { }
  inline VectorNumT(const Vector& vec)                             : Parent(vec) { }
  inline VectorNumT(size_type count, const T& value = T())         : Parent(count, value) { }
  inline VectorNumT(const VectorNumT& other)                       : Parent(other) { }

#ifndef SWIG
  inline VectorNumT(std::initializer_list<T> init)                 : Parent(init) { }
#endif

// Only for C++ users
// These functions are not available in target language
// because numerical vectors are converted in target language vectors
public:
  inline bool isSame(const VectorNumT& v, double eps = 1.e-10) const;

  inline T sum() const;
  inline T min() const;
  inline T max() const;
  inline double mean() const;
  inline double norm() const;

  inline T innerProduct(const VectorNumT<T>& v) const;

  inline const VectorNumT<T>& add(const VectorNumT<T>& v);
  inline const VectorNumT<T>& subtract(const VectorNumT<T>& v);
  inline const VectorNumT<T>& multiply(const VectorNumT<T>& v);
  inline const VectorNumT<T>& divide(const VectorNumT<T>& v);

  inline const VectorNumT<T>& add(const T& v);
  inline const VectorNumT<T>& subtract(const T& v);
  inline const VectorNumT<T>& multiply(const T& v);
  inline const VectorNumT<T>& divide(const T& v);
};

template <typename T>
bool VectorNumT<T>::isSame(const VectorNumT& other,
                           double eps) const
{
  if (other.size() != VectorNumT::size()) return false;
  for (size_type i = 0, n = VectorNumT::size(); i < n; i++)
    if (abs(VectorNumT::at(i) - other.at(i)) > eps) return false;
  return true;
}

template <typename T>
T VectorNumT<T>::sum() const
{
  if (VectorNumT::size() <= 0) return T();
  T sum = 0.;
  for (size_type i = 0, n = VectorNumT::size(); i < n; i++)
    sum += VectorNumT::_v->at(i);
  return (sum);
}

template <typename T>
T VectorNumT<T>::max() const
{
  if (VectorNumT::size() <= 0) return 0.;
  T max = std::numeric_limits<T>::min();
  for (auto v : *VectorNumT::_v)
    if (v > max) max = v;
  return (max);
}

template <typename T>
T VectorNumT<T>::min() const
{
  if (VectorNumT::size() <= 0) return 0.;
  T min = std::numeric_limits<T>::max();
  for (auto v : *VectorNumT::_v)
    if (v < min) min = v;
  return (min);
}

template <typename T>
double VectorNumT<T>::mean() const
{
  if (VectorNumT::size() <= 0) return static_cast<T>(NAN);
  double s = static_cast<double>(sum());
  return (s / static_cast<double>(VectorNumT::_v->size()));
}

template <typename T>
double VectorNumT<T>::norm() const
{
  double ip = static_cast<double>(innerProduct(*this));
  return sqrt(ip);
}

template <typename T>
T VectorNumT<T>::innerProduct(const VectorNumT<T>& v) const
{
  if (v.size() != VectorNumT::size())
    throw("VectorNumT<T>::innerProduct: Wrong size");
  T prod = 0.;
  for (size_type i = 0, n = VectorNumT::size(); i < n; i++)
    prod += VectorNumT::at(i) * v[i];
  return prod;
}

template <typename T>
const VectorNumT<T>& VectorNumT<T>::add(const VectorNumT<T>& v)
{
  if (v.size() != VectorNumT::size())
    throw("VectorNumT<T>::add: Wrong size");
  for (size_type i = 0, n = VectorNumT::size(); i < n; i++)
    VectorNumT::set(i, VectorNumT::at(i)+v[i]);
  return *this;
}

template <typename T>
const VectorNumT<T>& VectorNumT<T>::subtract(const VectorNumT<T>& v)
{
  if (v.size() != VectorNumT::size())
    throw("VectorNumT<T>::subtract: Wrong size");
  for (size_type i = 0, n = VectorNumT::size(); i < n; i++)
    VectorNumT::set(i, VectorNumT::at(i)-v[i]);
  return *this;
}

template <typename T>
const VectorNumT<T>& VectorNumT<T>::multiply(const VectorNumT<T>& v)
{
  if (v.size() != VectorNumT::size())
    throw("VectorNumT<T>::multiply: Wrong size");
  for (size_type i = 0, n = VectorNumT::size(); i < n; i++)
    VectorNumT::set(i, VectorNumT::at(i)*v[i]);
  return *this;
}

template <typename T>
const VectorNumT<T>& VectorNumT<T>::divide(const VectorNumT<T>& v)
{
  if (v.size() != VectorNumT::size())
    throw("VectorNumT<T>::divide: Wrong size");
  for (size_type i = 0, n = VectorNumT::size(); i < n; i++)
  {
    if (abs(v[i]) < 1.e-10)
      throw("VectorNumT<T>::divide: division by 0");
    VectorNumT::set(i, VectorNumT::at(i)/v[i]);
  }
  return *this;
}

template <typename T>
const VectorNumT<T>& VectorNumT<T>::add(const T& v)
{
  std::for_each(VectorNumT::begin(), VectorNumT::end(), [v](T& d) { d += v;});
  return *this;
}

template <typename T>
const VectorNumT<T>& VectorNumT<T>::subtract(const T& v)
{
  std::for_each(VectorNumT::begin(), VectorNumT::end(), [v](T& d) { d -= v;});
  return *this;
}

template <typename T>
const VectorNumT<T>& VectorNumT<T>::multiply(const T& v)
{
  std::for_each(VectorNumT::begin(), VectorNumT::end(), [v](T& d) { d *= v;});
  return *this;
}

template <typename T>
const VectorNumT<T>& VectorNumT<T>::divide(const T& v)
{
  if (abs(v) < 1.e-10)
    throw("VectorNumT<T>::divide: division by 0");
  std::for_each(VectorNumT::begin(), VectorNumT::end(), [v](T& d) { d /= v;});
  return *this;
}

// Do not export VectorXXX to SWIG (no more instantiation needed)
/*
// Force instantiation for VectorNumT of int and double
// Needs instantiation of base class for int and double (see VectorT.hpp)
#ifndef SWIG // To avoid Swig error "Explicit template instantiation ignored."
template class VectorNumT<int>;
template class VectorT<VectorNumT<int> >;
template class VectorNumT<double>;
template class VectorT<VectorNumT<double> >;
#endif
*/

typedef VectorNumT<int> VectorInt;
typedef VectorT<VectorNumT<int> > VectorVectorInt;
typedef VectorNumT<double> VectorDouble;
typedef VectorT<VectorNumT<double> > VectorVectorDouble;
