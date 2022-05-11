#include "args.hpp"

#include <iostream>
#include <sstream>

int testInt(int a)
{
  std::cout << "Test int: " << a << std::endl;
  return a;
}

VectorInt testVectorInt(const VectorInt& a)
{
  std::cout << "Test VectorInt: [";
  for(auto v : a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return a;
}

String testString(const String& a)
{
  std::cout << "Test String: " << a << std::endl;
  return a;
}

VectorString testVectorString(const VectorString& a)
{
  std::cout << "Test VectorString: [";
  for(auto v : a)
    std::cout << v << " ";
  std::cout << "]" << std::endl;
  return a;
}
