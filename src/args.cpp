#include "args.hpp"

#include <iostream>

TypeClass::TypeClass()
: _varInt()
, _varDouble()
, _varString()
, _varVectorInt()
, _varVectorDouble()
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
