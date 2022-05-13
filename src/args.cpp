#include "args.hpp"

#include <iostream>
#include <sstream>

int testInt(int a)
{
  std::cout << "Test int: " << a << std::endl;
  return a;
}

int testIntPtr(const int* a)
{
  std::cout << "Test int Pointer: " << *a << std::endl;
  return *a;
}

int* testIntCreate(int a)
{
  int* na = new int(a);
  std::cout << "Test int Create: " << a << std::endl;
  return na;
}

VectorInt testVectorInt(const VectorInt& a)
{
  std::cout << "Test VectorInt: [";
  for(auto v : a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return a;
}

VectorInt testVectorIntPtr(const VectorInt* a)
{
  std::cout << "Test VectorInt Pointer: [";
  for(auto v : *a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return *a;
}

VectorInt* testVectorIntCreate(const VectorInt& a)
{
  VectorInt* na = new VectorInt();
  std::cout << "Test VectorInt Create: [";
  for(auto v : a)
  {
    std::cout << v << " ";
    na->push_back(v);
  }
  std::cout << "]" << std::endl;
  return na;
}

String testString(const String& a)
{
  std::cout << "Test String: " << a << std::endl;
  return a;
}

String testStringPtr(const String* a)
{
  std::cout << "Test String Pointer: " << *a << std::endl;
  return *a;
}

String* testStringCreate(const String& a)
{
  String* na = new String(a);
  std::cout << "Test String Create: " << a << std::endl;
  return na;
}

VectorString testVectorString(const VectorString& a)
{
  std::cout << "Test VectorString: [";
  for(auto v : a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return a;
}

VectorString testVectorStringPtr(const VectorString* a)
{
  std::cout << "Test VectorString Pointer: [";
  for(auto v : *a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return *a;
}

VectorString* testVectorStringCreate(const VectorString& a)
{
  VectorString* na = new VectorString();
  std::cout << "Test VectorString Create: [";
  for(auto v : a)
  {
    std::cout << v << " ";
    na->push_back(v);
  }
  std::cout << "]" << std::endl;
  return na;
}
