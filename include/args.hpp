#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"

#include "VectorT.hpp"
#include "VectorNumT.hpp"


class MYFIBO_EXPORT TypeClass
{
public:
  TypeClass();
  ~TypeClass();
//                                                                             //   R         Python

  int testInt(int a);                                                          //   OK        OK
  const int& testIntRef(const int& a);                                         //   OK        OK
  const int* testIntPtr(const int* a);                                         //   OK_r1     ## NOK_p1

  VectorInt testVectorInt(VectorInt a);                                        //   OK        OK_p2
  const VectorInt& testVectorIntRef(const VectorInt& a);                       //   OK        OK_p2
  const VectorInt* testVectorIntPtr(const VectorInt* a);                       //   OK        OK_p2

  VectorVectorInt testVVectorInt(VectorVectorInt a);                           //   OK        OK_p2
  const VectorVectorInt& testVVectorIntRef(const VectorVectorInt& a);          //   OK        OK_p2
  const VectorVectorInt* testVVectorIntPtr(const VectorVectorInt* a);          //   OK        OK_p2

  double testDouble(double a);                                                 //   OK        OK
  const double& testDoubleRef(const double& a);                                //   OK        OK
  const double* testDoublePtr(const double* a);                                //   OK_r1     ## NOK_p1

  VectorDouble testVectorDouble(VectorDouble a);                               //   OK        OK
  const VectorDouble& testVectorDoubleRef(const VectorDouble& a);              //   OK        OK
  const VectorDouble* testVectorDoublePtr(const VectorDouble* a);              //   OK        OK

  VectorVectorDouble testVVectorDouble(VectorVectorDouble a);                  //   OK        OK
  const VectorVectorDouble& testVVectorDoubleRef(const VectorVectorDouble& a); //   OK        OK
  const VectorVectorDouble* testVVectorDoublePtr(const VectorVectorDouble* a); //   OK        OK

  String testString(String a);                                                 //   OK        OK
  const String& testStringRef(const String& a);                                //   OK        OK
  const String*testStringPtr(const String* a);                                 //   ## NOK_r2 ## NOK_p1

  VectorString testVectorString(VectorString a);                               //   OK        OK
  const VectorString& testVectorStringRef(const VectorString& a);              //   OK        OK
  const VectorString* testVectorStringPtr(const VectorString* a);              //   OK        OK

  void testIntOverload(int a) const;                                           //   OK_r3     OK
  void testIntOverload(const VectorInt& a) const;                              //   OK        OK_p2
  void testDoubleOverload(double a) const;                                     //   OK_r3     OK
  void testDoubleOverload(const VectorDouble& a) const;                        //   OK        OK
  void testStringOverload(String a) const;                                     //   OK_r3     OK
  void testStringOverload(const VectorString& a) const;                        //   OK        OK

private:
  int                _varInt;
  double             _varDouble;
  String             _varString;
  VectorInt          _varVectorInt;
  VectorVectorInt    _varVVectorInt;
  VectorDouble       _varVectorDouble;
  VectorVectorDouble _varVVectorDouble;
  VectorString       _varVectorString;
};

/*

 OK_r1: Call OK but object returned is externalptr so the value is not interpretable

 NOK_r2: R Crashes with SEGV (don't know why)

 OK_r3: Call OK but a single value is seen as a vector

 NOK_p1: TypeError: in method 'testXXXPtr', argument 1 of type 'XXX const *'

 OK_p2: Call OK but if argument is a NumPy array, items must be dtype='object' (not integers)

*/
