// TODO : Unable director feature for polymorphism doesn't work
%feature(director) AParent;
%{
  #include "myfibo_export.hpp"
  #include "fibo_define.hpp"
  #include "fibo.hpp"
  #include "args.hpp"
  #include "polymorph.hpp"
%}
