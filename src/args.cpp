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

VectorInt TypeClass::testVectorInt(VectorInt a)
{
  _varVectorInt = a;
  std::cout << "Test VectorInt: [";
  for(auto v : a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return _varVectorInt;
}

const VectorInt& TypeClass::testVectorIntRef(const VectorInt& a)
{
  _varVectorInt = a;
  std::cout << "Test VectorInt Reference: [";
  for(auto v : a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return _varVectorInt;
}

const VectorInt* TypeClass::testVectorIntPtr(const VectorInt* a)
{
  _varVectorInt = *a;
  std::cout << "Test VectorInt Pointer: [";
  for(auto v : *a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return &_varVectorInt;
}

VectorVectorInt TypeClass::testVVectorInt(VectorVectorInt a)
{
  _varVVectorInt = a;
  std::cout << "Test VectorVectorInt: [" << std::endl;
  for(auto v1 : a)
  {
    std::cout << "[";
    for(auto v2 : v1)
      std::cout << v2 << " ";
    std::cout << "]" << std::endl;
  }
  std::cout << "]" << std::endl;
  return _varVVectorInt;
}

const VectorVectorInt& TypeClass::testVVectorIntRef(const VectorVectorInt& a)
{
  _varVVectorInt = a;
  std::cout << "Test VectorVectorInt Reference: [" << std::endl;
  for(auto v1 : a)
  {
    std::cout << "[";
    for(auto v2 : v1)
      std::cout << v2 << " ";
    std::cout << "]" << std::endl;
  }
  std::cout << "]" << std::endl;
  return _varVVectorInt;
}

const VectorVectorInt* TypeClass::testVVectorIntPtr(const VectorVectorInt* a)
{
  _varVVectorInt = *a;
  std::cout << "Test VectorVectorInt Pointer: [" << std::endl;
  for(auto v1 : *a)
  {
    std::cout << "[";
    for(auto v2 : v1)
      std::cout << v2 << " ";
    std::cout << "]" << std::endl;
  }
  std::cout << "]" << std::endl;
  return &_varVVectorInt;
}


VectorVectorDouble TypeClass::testVVectorDouble(VectorVectorDouble a)
{
  _varVVectorDouble = a;
  std::cout << "Test VectorVectorDouble: [" << std::endl;
  for(auto v1 : a)
  {
    std::cout << "[";
    for(auto v2 : v1)
      std::cout << v2 << " ";
    std::cout << "]" << std::endl;
  }
  std::cout << "]" << std::endl;
  return _varVVectorDouble;
}

const VectorVectorDouble& TypeClass::testVVectorDoubleRef(const VectorVectorDouble& a)
{
  _varVVectorDouble = a;
  std::cout << "Test VectorVectorDouble Reference: [" << std::endl;
  for(auto v1 : a)
  {
    std::cout << "[";
    for(auto v2 : v1)
      std::cout << v2 << " ";
    std::cout << "]" << std::endl;
  }
  std::cout << "]" << std::endl;
  return _varVVectorDouble;
}

const VectorVectorDouble* TypeClass::testVVectorDoublePtr(const VectorVectorDouble* a)
{
  _varVVectorDouble = *a;
  std::cout << "Test VectorVectorDouble Pointer: [" << std::endl;
  for(auto v1 : *a)
  {
    std::cout << "[";
    for(auto v2 : v1)
      std::cout << v2 << " ";
    std::cout << "]" << std::endl;
  }
  std::cout << "]" << std::endl;
  return &_varVVectorDouble;
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

VectorDouble TypeClass::testVectorDouble(VectorDouble a)
{
  _varVectorDouble = a;
  std::cout << "Test VectorDouble: [";
  for(auto v : a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return _varVectorDouble;
}

const VectorDouble& TypeClass::testVectorDoubleRef(const VectorDouble& a)
{
  _varVectorDouble = a;
  std::cout << "Test VectorDouble Reference: [";
  for(auto v : a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return _varVectorDouble;
}

const VectorDouble* TypeClass::testVectorDoublePtr(const VectorDouble* a)
{
  _varVectorDouble = *a;
  std::cout << "Test VectorDouble Pointer: [";
  for(auto v : *a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return &_varVectorDouble;
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

VectorString TypeClass::testVectorString(VectorString a)
{
  _varVectorString = a;
  std::cout << "Test VectorString: [";
  for(auto v : a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return _varVectorString;
}

const VectorString& TypeClass::testVectorStringRef(const VectorString& a)
{
  _varVectorString = a;
  std::cout << "Test VectorString Reference: [";
  for(auto v : a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return _varVectorString;
}

const VectorString* TypeClass::testVectorStringPtr(const VectorString* a)
{
  _varVectorString = *a;
  std::cout << "Test VectorString Pointer: [";
  for(auto v : *a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return &_varVectorString;
}
