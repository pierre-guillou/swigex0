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
  const int* testIntPtr(const int* a);                                         //   X_r1      X_p1

  VectorInt testVectorInt(VectorInt a);                                        //   OK        OK
  const VectorInt& testVectorIntRef(const VectorInt& a);                       //   OK        OK
  const VectorInt* testVectorIntPtr(const VectorInt* a);                       //   OK        OK

  VectorVectorInt testVVectorInt(VectorVectorInt a);                           //   OK        OK
  const VectorVectorInt& testVVectorIntRef(const VectorVectorInt& a);          //   OK        OK
  const VectorVectorInt* testVVectorIntPtr(const VectorVectorInt* a);          //   OK        OK

  double testDouble(double a);                                                 //   OK        OK
  const double& testDoubleRef(const double& a);                                //   OK        OK
  const double* testDoublePtr(const double* a);                                //   X_r1      X_p1

  VectorDouble testVectorDouble(VectorDouble a);                               //   OK        OK
  const VectorDouble& testVectorDoubleRef(const VectorDouble& a);              //   OK        OK
  const VectorDouble* testVectorDoublePtr(const VectorDouble* a);              //   OK        OK

  VectorVectorDouble testVVectorDouble(VectorVectorDouble a);                  //   OK        OK
  const VectorVectorDouble& testVVectorDoubleRef(const VectorVectorDouble& a); //   OK        OK
  const VectorVectorDouble* testVVectorDoublePtr(const VectorVectorDouble* a); //   OK        OK

  String testString(String a);                                                 //   OK        OK
  const String& testStringRef(const String& a);                                //   OK        OK
  const String*testStringPtr(const String* a);                                 //   X_r2      X_p1

  VectorString testVectorString(VectorString a);                               //   OK        OK
  const VectorString& testVectorStringRef(const VectorString& a);              //   OK        OK
  const VectorString* testVectorStringPtr(const VectorString* a);              //   OK        OK

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

 X_r1: Call OK but object return is externalptr so the value is not interpretable

 X_r2: R Crashes with SEGV (don't know why)

 X_p1: TypeError: in method 'testXXXPtr', argument 1 of type 'XXX const *'

*/
