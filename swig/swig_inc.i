// TODO : Unable director feature for polymorphism doesn't work
%feature(director) AParent;

%{
  #include "myfibo_export.hpp"
  #include "fibo_define.hpp"
  #include "VectorT.hpp"
  #include "VectorNumT.hpp"
  #include "fibo.hpp"
  #include "args.hpp"
  #include "polymorph.hpp"
  #include "stdoutredirect.hpp"
%}


////////////////////////////
//        Typemaps        //
////////////////////////////

// Mandatory for using swig::asptr and swig::from for std::vectors
%include std_vector.i
%include std_string.i
%template(DoNotUseVectorIntStd)     std::vector< int >;
%template(DoNotUseVectorDoubleStd)  std::vector< double >;
%template(DoNotUseVectorStringStd)  std::vector< std::string >; // Keep std::string here otherwise asptr fails!
%template(DoNotUseVVectorIntStd)    std::vector< std::vector< int > >;
%template(DoNotUseVVectorDoubleStd) std::vector< std::vector< double > >;


////////////////////////////////////////////////
// Conversion Target language => C++

// Note : Before including this file :
//        - vectorToCpp, vectorVectorToCpp and convertToCpp 
//          functions must be defined in ToCpp fragment
//        - vectorFromCpp, vectorVectorFromCpp and convertFromCpp 
//          functions must be defined in FromCpp fragment

// Convert scalar arguments by value
%typemap(in, fragment="ToCpp") int,
                               double
{
  const int errcode = convertToCpp($input, $1);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
}

// Convert scalar argument by reference (cannot convert pointers)
%typemap(in, fragment="ToCpp") const int&    (int val),
                               const double& (double val)
{
  const int errcode = convertToCpp($input, val);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
  $1 = &val;
}

%typemap(in, fragment="ToCpp") VectorInt,
                               VectorDouble,
                               VectorString
{ 
  const int errcode = vectorToCpp($input, $1);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
}

%typemap(in, fragment="ToCpp") VectorVectorInt,
                               VectorVectorDouble
{ 
  const int errcode = vectorVectorToCpp($input, $1);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
}

%typemap(in, fragment="ToCpp") const VectorInt&    (VectorInt vec),
                               const VectorInt*    (VectorInt vec),
                               const VectorDouble& (VectorDouble vec),
                               const VectorDouble* (VectorDouble vec),
                               const VectorString& (VectorString vec),
                               const VectorString* (VectorString vec)
{
  const int errcode = vectorToCpp($input, vec);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
  $1 = &vec;
}

%typemap(in, fragment="ToCpp") const VectorVectorInt&    (VectorVectorInt vec),
                               const VectorVectorInt*    (VectorVectorInt vec),
                               const VectorVectorDouble& (VectorVectorDouble vec),
                               const VectorVectorDouble* (VectorVectorDouble vec)
{
  const int errcode = vectorVectorToCpp($input, vec);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
  $1 = &vec;
}

////////////////////////////////////////////////
// Conversion C++ => Target language

%typemap(out, fragment="FromCpp") VectorInt, 
                                  VectorDouble, 
                                  VectorString
{
  const int errcode = vectorFromCpp(&($result), result);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

%typemap(out, fragment="FromCpp") VectorInt*,    VectorInt&,
                                  VectorDouble*, VectorDouble&,
                                  VectorString*, VectorString&
{
  const int errcode = vectorFromCpp(&($result), *result);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

%typemap(out, fragment="FromCpp") VectorVectorInt, 
                                  VectorVectorDouble
{
  const int errcode = vectorVectorFromCpp(&($result), result);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

%typemap(out, fragment="FromCpp") VectorVectorInt*,    VectorVectorInt&,
                                  VectorVectorDouble*, VectorVectorDouble&
{
  const int errcode = vectorVectorFromCpp(&($result), *result);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

