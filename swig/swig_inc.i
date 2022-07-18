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
%template(DoNotUseVectorIntStd)    std::vector< int >;
%template(DoNotUseVectorDoubleStd) std::vector< double >;
%template(DoNotUseVectorStringStd) std::vector< std::string >; // Keep std::string here !


////////////////////////////////////////////////
// Conversion Target language => C++

// Note : fillVector and convert2cpp functions
//        must be defined in ToVectorT and Conversions
//        fragments before including this file

%typemap(in, fragment="ToVectorT") VectorInt,
                                   VectorDouble,
                                   VectorString
{ 
  const int errcode = fillVector($input, $1);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
}

%typemap(in, fragment="ToVectorT") const VectorInt&    (VectorInt vec),
                                   const VectorInt*    (VectorInt vec),
                                   const VectorDouble& (VectorDouble vec),
                                   const VectorDouble* (VectorDouble vec),
                                   const VectorString& (VectorString vec),
                                   const VectorString* (VectorString vec)
{
  const int errcode = fillVector($input, vec);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
  $1 = &vec;
}

// Convert scalar arguments by value
%typemap(in, fragment="Conversions") int,
                                     double
{
  const int errcode = convert2cpp($input, $1);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
}

// Convert scalar argument by reference (cannot convert pointers)
%typemap(in, fragment="Conversions") const int&    (int val),
                                     const double& (double val)
{
  const int errcode = convert2cpp($input, val);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
  $1 = &val;
}

////////////////////////////////////////////////
// Conversion C++ => Target language

%typemap(out) VectorInt, 
              VectorDouble, 
              VectorString
{
  $result = swig::from(result.getVector());
}

%typemap(out) VectorInt*,    VectorInt&,
              VectorDouble*, VectorDouble&,
              VectorString*, VectorString&
{
  $result = swig::from(result->getVector());
}
