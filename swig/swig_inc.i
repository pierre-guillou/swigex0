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
  #include "typemap.hpp"
  #include "stdoutredirect.hpp"
%}

// Mandatory for using swig::asptr for std::vectors
%include std_vector.i
%include std_string.i
%template(VectorIntStd)    std::vector< int >;
%template(VectorDoubleStd) std::vector< double >;
%template(VectorStringStd) std::vector< std::string >;