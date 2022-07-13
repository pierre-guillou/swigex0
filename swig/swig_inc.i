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

// Mandatory for using swig::asptr for std::vectors
%include std_vector.i
%include std_string.i
%template(VectorIntStd)    std::vector< int >;
%template(VectorDoubleStd) std::vector< double >;
%template(VectorStringStd) std::vector< std::string >;


////////////////////////////////////////////////
// Conversion Target language => C++

// Note : fillVector function must be defined in ToVectorT fragment before including this file

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
