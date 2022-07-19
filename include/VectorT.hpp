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
class MYFIBO_EXPORT VectorT
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
  inline VectorT()                                                 : _v(std::make_shared<Vector>()) { }
  inline VectorT(const Vector& vec)                                : _v(std::make_shared<Vector>(vec)) { }
  inline VectorT(size_type count, const T& value = T())            : _v(std::make_shared<Vector>(count, value)) { }
  inline VectorT(const VectorT& other)                             : _v(other._v) { }
#ifndef SWIG
  inline VectorT(std::initializer_list<T> init)                    : _v(std::make_shared<Vector>(init)) { }
  inline VectorT(VectorT&& other)                                  { _v.swap(other._v); }
#endif
  inline ~VectorT()                                                { }

#ifndef SWIG
  inline operator const Vector&() const                            { return *_v; }
#endif

  inline Vector& getVector() const                                 { return *_v; }
  inline Vector* getVectorPtr() const                              { return _v.get(); }

#ifndef SWIG
  inline VectorT& operator=(const Vector& vec)                     { _detach(); *_v = vec; return (*this); }
  inline VectorT& operator=(const VectorT& other)                  { _detach(); _v = other._v; return (*this); }
  inline VectorT& operator=(VectorT&& other)                       { _v.swap(other._v); return (*this); }
  inline VectorT& operator=(std::initializer_list<T> init)         { _detach(); (*_v) = init; return (*this); }
#endif

  inline bool operator==(const VectorT& other) const               { return *_v == *other._v; }
  inline bool operator!=(const VectorT& other) const               { return *_v != *other._v; }
  inline bool operator <(const VectorT& other) const               { return *_v  < *other._v; }
  inline bool operator<=(const VectorT& other) const               { return *_v <= *other._v; }
  inline bool operator >(const VectorT& other) const               { return *_v  > *other._v; }
  inline bool operator>=(const VectorT& other) const               { return *_v >= *other._v; }

  inline const T& at(size_type pos) const                          { if (pos >= _v->size()) throw("VectorT<T>::at: index out of range");                    return _v->operator[](pos); }
#ifndef SWIG
  inline T& operator[](size_type pos)                              { if (pos >= _v->size()) throw("VectorT<T>::operator[]: index out of range"); _detach(); return _v->operator[](pos); }
  inline const T& operator[](size_type pos) const                  { if (pos >= _v->size()) throw("VectorT<T>::operator[]: index out of range");            return _v->operator[](pos); }
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
  inline void push_front(const T& value)                           { _detach(); _v->insert(begin(), value); }
#ifndef SWIG
  inline void push_back(const T&& value)                           { _detach(); _v->push_back(value); }
  inline void push_front(const T&& value)                          { _detach(); _v->insert(begin(), value); }
#endif
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
  inline VectorT& operator<<(const T& value)                       { _detach(); _v->push_back(value); return (*this); }
  inline VectorT& operator<<(const VectorT<T>& v)                  { _detach(); reserve(size() + v.size()); std::for_each(v.cbegin(), v.cend(), [&](const T& value) { _v->push_back(value); }); return (*this); }
#endif

  inline void swap(VectorT& other);
  inline bool contains(const T& value) const;
  inline void fill(const T& value, size_type size = -1);
  inline void assign(const T* tab, size_type size);
  inline void set(size_type i, const T& value);

protected:
  std::shared_ptr<Vector> _v;

private:
  inline void _detach();
};

template <typename T>
void VectorT<T>::swap(VectorT& other)
{
  std::swap(_v, other._v);
}

template <typename T>
bool VectorT<T>::contains(const T& value) const
{
  return (std::find(cbegin(), cend(), value) != cend());
}

template <typename T>
void VectorT<T>::fill(const T& value, size_type size)
{
  _detach();
  _v->resize(size);
  std::fill(begin(), end(), value);
}

template <typename T>
void VectorT<T>::assign(const T* tab, size_type size)
{
  _detach();
  _v->assign(tab, tab+size);
}

template <typename T>
void VectorT<T>::set(size_type i, const T& value)
{
  _detach();
  operator[](i) = value;
}

template <typename T>
void VectorT<T>::_detach()
{
  if (_v.unique())
    return;
  _v = std::make_shared<Vector>(*_v);
}


// Force instantiation for VectorT (for windows export)
#if defined(WIN32) || defined(_WIN32) || defined(WIN64) || defined(_WIN64)
  // Do not export VectorXXX to SWIG (no more instantiation needed)
  #ifndef SWIG
    MYFIBO_TEMPLATE_EXPORT template class VectorT<int>;
    MYFIBO_TEMPLATE_EXPORT template class VectorT<double>;
    MYFIBO_TEMPLATE_EXPORT template class VectorT<String>;
  #endif
#endif

typedef VectorT<int> VectorTInt;
typedef VectorT<double> VectorTDouble;
typedef VectorT<String> VectorString;
