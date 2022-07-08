#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"
#include "VectorT.hpp"
#include "VectorNumT.hpp"

//                                                                         //   R         Python
// Global functions
MYFIBO_EXPORT int testInt(int a);                                          //   OK        OK
MYFIBO_EXPORT int testIntPtr(const int* a);                                //   OK        X_p1
MYFIBO_EXPORT int* testIntCreate(int a);                                   //   X_r1      X_p2

MYFIBO_EXPORT VectorInt testVectorInt(const VectorInt& a);                 //   OK        OK
MYFIBO_EXPORT VectorInt testVectorIntPtr(const VectorInt* a);              //   X_r0      X_p1
MYFIBO_EXPORT VectorInt* testVectorIntCreate(const VectorInt& a);          //   X_r3      x_p3

MYFIBO_EXPORT String testString(const String& a);                          //   OK        OK
MYFIBO_EXPORT String testStringPtr(const String* a);                       //   X_r0      X_p1
MYFIBO_EXPORT String* testStringCreate(const String& a);                   //   X_r2      X_p2

MYFIBO_EXPORT VectorString testVectorString(const VectorString& a);        //   OK        OK
MYFIBO_EXPORT VectorString testVectorStringPtr(const VectorString* a);     //   X_r0      X_p1
MYFIBO_EXPORT VectorString* testVectorStringCreate(const VectorString& a); //   OK        X_p3

/*
 X_r0: R Crash with SEGV in SWIG_R_ConvertPtr

 X_r1: Arg OK but return value NOK:

       Erreur dans getClass(Class, where = topenv(parent.frame())) :
        “_p_int” is not a defined class

 X_r2: Arg OK but return value NOK:

       Erreur dans getClass(Class, where = topenv(parent.frame())) :
        “_p_std__string” is not a defined class

 X_r3: Call OK, but object returned is externalptr (TODO : so why testVectorStringCreate is Ok ?):

       Erreur dans vi[1] : objet de type 'externalptr' non indiçable

 X_p1: TypeError: in method 'testXXXPtr', argument 1 of type 'XXX const *'

 X_p2: Call OK but object returned is SwigPyObject so the value is not interpretable

 X_p3: Call OK but object returned is 'VectorXXX' and is not subscriptable

*/
