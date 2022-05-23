%module(directors="1") myfibo

// Include C++ library SWIG interface files (Keep order!)
%include ../swig/swig_inc.i
%include ../swig/swig_exp.i

// TODO : Redirection of std::cout for windows RGui.exe users