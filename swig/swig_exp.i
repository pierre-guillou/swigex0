// Sensitive file ! Keep Order

// Cast strings into native type of the target language
%include std_string.i
%include std_vector.i

// Global files to be wrapped from myfibo library
%include myfibo_export.hpp // Do not forget this file in priority (for SWIG preprocessor)
%include fibo_define.hpp

// Cast vectors of integers into native type of the target language
//%include VectorT.hpp // TODO : Use VectorT
%template(VectorString) std::vector<std::string>;
%template(VectorInt)    std::vector<int>;
%template(VectorDouble) std::vector<double>;

// Rest of the header files from myfibo library
%include fibo.hpp
%include args.hpp
%include polymorph.hpp
%include stdoutredirect.hpp

// For suppressing SWIG warning due to -keyword option (if used)
#pragma SWIG nowarn=511
#pragma SWIG nowarn=506

