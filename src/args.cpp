#include "args.hpp"

#include <iostream>

TypeClass::TypeClass()
: _varInt()
, _varDouble()
, _varString()
, _varVectorInt()
, _varVVectorInt()
, _varVectorDouble()
, _varVVectorDouble()
, _varVectorString()
{

}
TypeClass::~TypeClass()
{

}

int TypeClass::testInt(int a)
{
  _varInt = a;
  std::cout << "Test int: " << a << std::endl;
  return _varInt;
}

const int& TypeClass::testIntRef(const int& a)
{
  _varInt = a;
  std::cout << "Test int Reference: " << a << std::endl;
  return _varInt;
}

const int* TypeClass::testIntPtr(const int* a)
{
  _varInt = *a;
  std::cout << "Test int Pointer: " << *a << std::endl;
  return &_varInt;
}

void TypeClass::testIntRefOut(int& a) const
{
  a = _varInt;
  std::cout << "Test int Reference Out: " << a << std::endl;
}

VectorInt TypeClass::testVectorInt(VectorInt a)
{
  _varVectorInt = a;
  std::cout << "Test VectorInt: " << a << std::endl;
  return _varVectorInt;
}

const VectorInt& TypeClass::testVectorIntRef(const VectorInt& a)
{
  _varVectorInt = a;
  std::cout << "Test VectorInt Reference: " << a << std::endl;
  return _varVectorInt;
}

const VectorInt* TypeClass::testVectorIntPtr(const VectorInt* a)
{
  _varVectorInt = *a;
  std::cout << "Test VectorInt Pointer: " << *a << std::endl;
  return &_varVectorInt;
}

void TypeClass::testVectorIntRefOut(VectorInt& a) const
{
  a = _varVectorInt;
  std::cout << "Test VectorInt Reference Out: " << a << std::endl;
}

VectorVectorInt TypeClass::testVVectorInt(VectorVectorInt a)
{
  _varVVectorInt = a;
  std::cout << "Test VectorVectorInt: " << a << std::endl;
  return _varVVectorInt;
}

const VectorVectorInt& TypeClass::testVVectorIntRef(const VectorVectorInt& a)
{
  _varVVectorInt = a;
  std::cout << "Test VectorVectorInt Reference: " << a << std::endl;
  return _varVVectorInt;
}

const VectorVectorInt* TypeClass::testVVectorIntPtr(const VectorVectorInt* a)
{
  _varVVectorInt = *a;
  std::cout << "Test VectorVectorInt Pointer: " << *a << std::endl;
  return &_varVVectorInt;
}

void TypeClass::testVVectorIntRefOut(VectorVectorInt& a) const
{
  a = _varVVectorInt;
  std::cout << "Test VectorVectorInt Reference Out: " << a << std::endl;
}

double TypeClass::testDouble(double a)
{
  _varDouble = a;
  std::cout << "Test double: " << a << std::endl;
  return _varDouble;
}

const double& TypeClass::testDoubleRef(const double& a)
{
  _varDouble = a;
  std::cout << "Test double Reference: " << a << std::endl;
  return _varDouble;
}

const double* TypeClass::testDoublePtr(const double* a)
{
  _varDouble = *a;
  std::cout << "Test double Pointer: " << *a << std::endl;
  return &_varDouble;
}

void TypeClass::testDoubleRefOut(double& a) const
{
  a = _varDouble;
  std::cout << "Test Double Reference Out: " << a << std::endl;
}

VectorDouble TypeClass::testVectorDouble(VectorDouble a)
{
  _varVectorDouble = a;
  std::cout << "Test VectorDouble: " << a << std::endl;
  return _varVectorDouble;
}

const VectorDouble& TypeClass::testVectorDoubleRef(const VectorDouble& a)
{
  _varVectorDouble = a;
  std::cout << "Test VectorDouble Reference: " << a << std::endl;
  return _varVectorDouble;
}

const VectorDouble* TypeClass::testVectorDoublePtr(const VectorDouble* a)
{
  _varVectorDouble = *a;
  std::cout << "Test VectorDouble Pointer: " << *a << std::endl;
  return &_varVectorDouble;
}

void TypeClass::testVectorDoubleRefOut(VectorDouble& a) const
{
  a = _varVectorDouble;
  std::cout << "Test VectorDouble Reference Out: " << a << std::endl;
}
/*
void TypeClass::testStdVectorDoubleRef(double a)
{
  std::cout << "Test testStdVectorDoubleRef [Scalar]: [" << a << "]" << std::endl;
}

void TypeClass::testStdVectorDoubleRef(const std::vector<double>& a)
{
  std::cout << "Test testStdVectorDoubleRef [Vector]: [";
  for(auto i : a)
  {
    std::cout << i << " ";
  }
  std::cout << "]" << std::endl;
}
*/
VectorVectorDouble TypeClass::testVVectorDouble(VectorVectorDouble a)
{
  _varVVectorDouble = a;
  std::cout << "Test VectorVectorDouble: " << a << std::endl;
  return _varVVectorDouble;
}

const VectorVectorDouble& TypeClass::testVVectorDoubleRef(const VectorVectorDouble& a)
{
  _varVVectorDouble = a;
  std::cout << "Test VectorVectorDouble Reference: " << a << std::endl;
  return _varVVectorDouble;
}

const VectorVectorDouble* TypeClass::testVVectorDoublePtr(const VectorVectorDouble* a)
{
  _varVVectorDouble = *a;
  std::cout << "Test VectorVectorDouble Pointer: " << *a << std::endl;
  return &_varVVectorDouble;
}

void TypeClass::testVVectorDoubleRefOut(VectorVectorDouble& a) const
{
  a = _varVVectorDouble;
  std::cout << "Test VectorVectorDouble Reference Out: " << a << std::endl;
}

String TypeClass::testString(String a)
{
  _varString = a;
  std::cout << "Test String: " << a << std::endl;
  return _varString;
}

const String& TypeClass::testStringRef(const String& a)
{
  _varString = a;
  std::cout << "Test String Reference: " << a << std::endl;
  return a;
}

const String* TypeClass::testStringPtr(const String* a)
{
  _varString = *a;
  std::cout << "Test String Pointer: " << *a << std::endl;
  return &_varString;
}

void TypeClass::testStringRefOut(String& a) const
{
  a = _varString;
  std::cout << "Test String Reference Out: " << a << std::endl;
}

VectorString TypeClass::testVectorString(VectorString a)
{
  _varVectorString = a;
  std::cout << "Test VectorString: " << a << std::endl;
  return _varVectorString;
}

const VectorString& TypeClass::testVectorStringRef(const VectorString& a)
{
  _varVectorString = a;
  std::cout << "Test VectorString Reference: " << a << std::endl;
  return _varVectorString;
}

const VectorString* TypeClass::testVectorStringPtr(const VectorString* a)
{
  _varVectorString = *a;
  std::cout << "Test VectorString Pointer: " << *a << std::endl;
  return &_varVectorString;
}

void TypeClass::testVectorStringRefOut(VectorString& a) const
{
  a = _varVectorString;
  std::cout << "Test VectorString Reference Out: " << a << std::endl;
}

void TypeClass::testIntOverload(int a) const
{
  std::cout << "Test int Overload [Scalar]: " << a << std::endl;
}
void TypeClass::testIntOverload(const VectorInt& a) const
{
  std::cout << "Test int Overload [Vector]: " << a << std::endl;
}
void TypeClass::testDoubleOverload(double a) const
{
  std::cout << "Test double Overload [Scalar]: " << a << std::endl;
}
void TypeClass::testDoubleOverload(const VectorDouble& a) const
{
  std::cout << "Test double Overload [Vector]: " << a << std::endl;
}
void TypeClass::testStringOverload(String a) const
{
  std::cout << "Test String Overload [Single]: " << a << std::endl;
}
void TypeClass::testStringOverload(const VectorString& a) const
{
  std::cout << "Test String Overload [Vector]: " << a << std::endl;
}
