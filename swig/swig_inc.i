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
