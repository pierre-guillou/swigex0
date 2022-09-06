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

// Convert scalar arguments by value
%typemap(in, fragment="ToCpp") int,
                               double,
                               String 
{
  const int errcode = convertToCpp($input, $1);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
}

// Convert scalar argument by reference
%typemap(in, fragment="ToCpp") int*       (int val), const int*       (int val),
                               int&       (int val), const int&       (int val),
                               double* (double val), const double* (double val),
                               double& (double val), const double& (double val) // Don't add String here otherwise "res2 not declared"
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

// Note : Before including this file :
//        - vectorFromCpp, vectorVectorFromCpp and objectFromCpp 
//          functions must be defined in FromCpp fragment

%typemap(out, fragment="FromCpp") int,
                                  double,
                                  String
{
  $result = objectFromCpp($1);
}

%typemap(out, fragment="FromCpp") int*,    const int*,    int&,    const int&,
                                  double*, const double*, double&, const double&,
                                  String*, const String*, String&, const String&
{
  $result = objectFromCpp(*$1);
}

%typemap(out, fragment="FromCpp") VectorInt, 
                                  VectorDouble, 
                                  VectorString
{
  const int errcode = vectorFromCpp(&($result), $1);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

%typemap(out, fragment="FromCpp") VectorInt*,    VectorInt&,
                                  VectorDouble*, VectorDouble&,
                                  VectorString*, VectorString&
{
  const int errcode = vectorFromCpp(&($result), *$1);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

%typemap(out, fragment="FromCpp") VectorVectorInt,
                                  VectorVectorDouble
{
  const int errcode = vectorVectorFromCpp(&($result), $1);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

%typemap(out, fragment="FromCpp") VectorVectorInt*,    VectorVectorInt&,
                                  VectorVectorDouble*, VectorVectorDouble&
{
  const int errcode = vectorVectorFromCpp(&($result), *$1);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

