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
  void testIntRefOut(int& a) const;                                            //   ## NOK_r4 ## NOK_p3

  VectorInt testVectorInt(VectorInt a);                                        //   OK        OK_p2
  const VectorInt& testVectorIntRef(const VectorInt& a);                       //   OK        OK_p2
  const VectorInt* testVectorIntPtr(const VectorInt* a);                       //   OK        OK_p2
  void testVectorIntRefOut(VectorInt& a) const;                                //   OK        OK

  VectorVectorInt testVVectorInt(VectorVectorInt a);                           //   OK        OK_p2
  const VectorVectorInt& testVVectorIntRef(const VectorVectorInt& a);          //   OK        OK_p2
  const VectorVectorInt* testVVectorIntPtr(const VectorVectorInt* a);          //   OK        OK_p2
  void testVVectorIntRefOut(VectorVectorInt& a) const;                         //   OK        OK

  double testDouble(double a);                                                 //   OK        OK
  const double& testDoubleRef(const double& a);                                //   OK        OK
  const double* testDoublePtr(const double* a);                                //   OK_r1     ## NOK_p1
  void testDoubleRefOut(double& a) const;                                      //   ## NOK_r4 ## NOK_p3

  VectorDouble testVectorDouble(VectorDouble a);                               //   OK        OK
  const VectorDouble& testVectorDoubleRef(const VectorDouble& a);              //   OK        OK
  const VectorDouble* testVectorDoublePtr(const VectorDouble* a);              //   OK        OK
  void testVectorDoubleRefOut(VectorDouble& a) const;                          //   OK        OK
  //void testStdVectorDoubleRef(double a);
  //void testStdVectorDoubleRef(const std::vector<double>& a);

  VectorVectorDouble testVVectorDouble(VectorVectorDouble a);                  //   OK        OK
  const VectorVectorDouble& testVVectorDoubleRef(const VectorVectorDouble& a); //   OK        OK
  const VectorVectorDouble* testVVectorDoublePtr(const VectorVectorDouble* a); //   OK        OK
  void testVVectorDoubleRefOut(VectorVectorDouble& a) const;                   //   OK        ## NOK_p3

  String testString(String a);                                                 //   OK        OK
  const String& testStringRef(const String& a);                                //   OK        OK
  const String*testStringPtr(const String* a);                                 //   ## NOK_r2 ## NOK_p1
  void testStringRefOut(String& a) const;                                      //   ## NOK_r4 ## NOK_p3

  VectorString testVectorString(VectorString a);                               //   OK        OK
  const VectorString& testVectorStringRef(const VectorString& a);              //   OK        OK
  const VectorString* testVectorStringPtr(const VectorString* a);              //   OK        OK
  void testVectorStringRefOut(VectorString& a) const;                          //   OK        OK

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

 OK_r3: Call OK but a vector with only 1 item will be seen as a scalar

 NOK_r4: R Crashes with SEGV (output argument for scalar not supported)

 NOK_p1: TypeError: in method 'testXXXPtr', argument 1 of type 'XXX const *'

 OK_p2: Call OK but if argument is a NumPy array, items must be dtype='object' (not integers)

 NOK_p3: Scalar output reference or pointer arguments are not possible with SWIG
         Instead, we must use %apply output (see https://www.swig.org/Doc4.0/SWIGDocumentation.html#Arguments)
*/
