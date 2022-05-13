#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"

/// Global functions
MYFIBO_EXPORT int testInt(int a);
MYFIBO_EXPORT int testIntPtr(const int* a); // Not in Python
MYFIBO_EXPORT int* testIntCreate(int a); // Not in R

MYFIBO_EXPORT VectorInt testVectorInt(const VectorInt& a);
MYFIBO_EXPORT VectorInt testVectorIntPtr(const VectorInt* a);
MYFIBO_EXPORT VectorInt* testVectorIntCreate(const VectorInt& a);

MYFIBO_EXPORT String testString(const String& a);
MYFIBO_EXPORT String testStringPtr(const String* a);
MYFIBO_EXPORT String* testStringCreate(const String& a);

MYFIBO_EXPORT VectorString testVectorString(const VectorString& a);
MYFIBO_EXPORT VectorString testVectorStringPtr(const VectorString* a);
MYFIBO_EXPORT VectorString* testVectorStringCreate(const VectorString& a);

