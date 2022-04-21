// No need of %module keyword when building using cmake UseSWIG
%module myfibo

// Include C++ library SWIG interface (Keep Order !!!!)
%include ../swig/swig_inc.i
%include ../swig/swig_exp.i

// Add target langage additional features

