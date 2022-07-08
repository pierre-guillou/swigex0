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

#include <vector>
#include <sstream>
#include <memory>
#include <limits>
#include <algorithm>
#include <cmath>

/***************************************************************************
 **
 ** Vector of T values (any type).
 ** T type must define copy constructor and assignment operator
 **
 ***************************************************************************/
template <typename T>
class MYFIBO_EXPORT VectorNumT
{
public:
  typedef std::vector<T> Vector;
  typedef typename Vector::value_type               value_type;
  typedef typename Vector::size_type                size_type;
  typedef typename Vector::iterator                 iterator;
  typedef typename Vector::const_iterator           const_iterator;
  typedef typename Vector::reverse_iterator         reverse_iterator;
  typedef typename Vector::const_reverse_iterator   const_reverse_iterator;

public:
  inline VectorNumT()                                              : _v(std::make_shared<Vector>()) { }
  inline VectorNumT(const Vector& vec)                             : _v(std::make_shared<Vector>(vec)) { }
  inline VectorNumT(size_type count, const T& value = T())         : _v(std::make_shared<Vector>(count, value)) { }
  inline VectorNumT(const VectorNumT& other)                       : _v(other._v) { }
#ifndef SWIG
  inline VectorNumT(std::initializer_list<T> init)                 : _v(std::make_shared<Vector>(init)) { }
  inline VectorNumT(VectorNumT&& other)                            { _v.swap(other._v); }
#endif
  inline ~VectorNumT()                                             { }

#ifndef SWIG
  inline operator const Vector&() const                            { return *_v; }
#endif

  inline Vector& getVector() const                                 { return *_v; }
  inline Vector* getVectorPtr() const                              { return _v.get(); }

#ifndef SWIG
  inline VectorNumT& operator=(const Vector& vec)                  { _detach(); *_v = vec; return (*this); }
  inline VectorNumT& operator=(const VectorNumT& other)            { _detach(); _v = other._v; return (*this); }
  inline VectorNumT& operator=(VectorNumT&& other)                 { _v.swap(other._v); return (*this); }
  inline VectorNumT& operator=(std::initializer_list<T> init)      { _detach(); (*_v) = init; return (*this); }
#endif

  inline bool operator==(const VectorNumT& other) const            { return *_v == *other._v; }
  inline bool operator!=(const VectorNumT& other) const            { return *_v != *other._v; }
  inline bool operator <(const VectorNumT& other) const            { return *_v  < *other._v; }
  inline bool operator<=(const VectorNumT& other) const            { return *_v <= *other._v; }
  inline bool operator >(const VectorNumT& other) const            { return *_v  > *other._v; }
  inline bool operator>=(const VectorNumT& other) const            { return *_v >= *other._v; }

  inline const T& at(size_type pos) const                          { if (pos >= _v->size()) throw("VectorNumT<T>::at: index out of range");                    return _v->operator[](pos); }
#ifndef SWIG
  inline T& operator[](size_type pos)                              { if (pos >= _v->size()) throw("VectorNumT<T>::operator[]: index out of range"); _detach(); return _v->operator[](pos); }
  inline const T& operator[](size_type pos) const                  { if (pos >= _v->size()) throw("VectorNumT<T>::operator[]: index out of range");            return _v->operator[](pos); }
#endif
  inline T& front()                                                { _detach(); return _v->front(); }
  inline const T& front() const                                    { return _v->front(); }
  inline T& back()                                                 { _detach(); return _v->back(); }
  inline const T& back() const                                     { return _v->back(); }
  inline T* data()                                                 { _detach(); return _v->data(); }
  inline const T* data() const                                     { return _v->data(); }
  inline const T* constData() const                                { return _v->data(); }

  inline bool empty() const                                        { return _v->empty(); }
  inline size_type size() const                                    { return _v->size(); }
  inline void reserve(size_type new_cap)                           { _v->reserve(new_cap); }
  inline size_type capacity() const                                { return _v->capacity(); }
  inline void clear()                                              { _detach(); _v->clear(); }

  inline void insert(size_type i, const T& value)                  { _detach(); _v->insert(begin() + i, value); }
  inline void insert(size_type i, size_type count, const T& value) { _detach(); _v->insert(begin() + i, count, value); }
  inline void remove(size_type i)                                  { _detach(); _v->erase(begin() + i); }
  inline void remove(size_type i, size_type count)                 { _detach(); _v->erase(begin() + i, begin() + i + count); }

  inline void push_back(const T& value)                            { _detach(); _v->push_back(value); }
  inline void push_back(const T&& value)                           { _detach(); _v->push_back(value); }
  inline void push_front(const T& value)                           { _detach(); _v->insert(begin(), value); }
  inline void push_front(const T&& value)                          { _detach(); _v->insert(begin(), value); }
  inline void resize(size_type count)                              { if (count == size()) return; _detach(); _v->resize(count); }
  inline void resize(size_type count, const T& value)              { if (count == size()) return; _detach(); _v->resize(count, value); }

  inline iterator begin()                                          { _detach(); return _v->begin(); }
  inline const_iterator begin() const                              { return _v->begin(); }
  inline const_iterator cbegin() const                             { return _v->cbegin(); }
  inline iterator end()                                            { _detach(); return _v->end(); }
  inline const_iterator end() const                                { return _v->end(); }
  inline const_iterator cend() const                               { return _v->cend(); }

  inline reverse_iterator rbegin()                                 { _detach(); return _v->rbegin(); }
  inline const_reverse_iterator crbegin() const                    { return _v->crbegin(); }
  inline reverse_iterator rend()                                   { _detach(); return _v->rend(); }
  inline const_reverse_iterator crend() const                      { return _v->crend(); }

#ifndef SWIG
  inline VectorNumT& operator<<(const T& value)                       { _detach(); _v->push_back(value); return (*this); }
  inline VectorNumT& operator<<(const VectorNumT<T>& v)                  { _detach(); reserve(size() + v.size()); std::for_each(v.cbegin(), v.cend(), [&](const T& value) { _v->push_back(value); }); return (*this); }
#endif

  inline void swap(VectorNumT& other);
  inline bool contains(const T& value) const;
  inline void fill(const T& value, size_type size = -1);
  inline void assign(const T* tab, size_type size);
  inline void set(size_type i, const T& value);

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

protected:
  std::shared_ptr<Vector> _v;

private:
  inline void _detach();
};

template <typename T>
void VectorNumT<T>::swap(VectorNumT& other)
{
  std::swap(_v, other._v);
}

template <typename T>
bool VectorNumT<T>::contains(const T& value) const
{
  return (std::find(cbegin(), cend(), value) != cend());
}

template <typename T>
void VectorNumT<T>::fill(const T& value, size_type size)
{
  _detach();
  _v->resize(size);
  std::fill(begin(), end(), value);
}

template <typename T>
void VectorNumT<T>::assign(const T* tab, size_type size)
{
  _detach();
  _v->assign(tab, tab+size);
}

template <typename T>
void VectorNumT<T>::set(size_type i, const T& value)
{
  _detach();
  operator[](i) = value;
}

template <typename T>
void VectorNumT<T>::_detach()
{
  if (_v.unique())
    return;
  _v = std::make_shared<Vector>(*_v);
}

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
  T sum = 0.; /// TODO : always possible ?
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
  T prod = 0.; /// TODO : always possible ?
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

// Force instantiation for Vector of int and double
#ifndef SWIG
template class VectorNumT<int>;
template class VectorNumT<double>;
#endif
typedef VectorNumT<int> VectorInt;
typedef VectorNumT<double> VectorDouble;
