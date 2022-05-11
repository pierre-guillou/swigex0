// Sensitive file ! Keep Order

// Cast strings into native type of the target language
%include std_string.i

// Cast vectors of integers into native type of the target language
%include std_vector.i
%template(VectorInt) std::vector<int>;
%template(VectorString) std::vector<std::string>;

// Files to be wrapped from myfibo library
%include myfibo_export.hpp // Do not forget this file in priority (for SWIG preprocessor)
%include fibo_define.hpp   // Do not forget this file to export String, VectorInt and VectorString from SWIG
%include fibo.hpp
%include args.hpp

// For suppressing SWIG warning due to -keyword option (if used)
#pragma SWIG nowarn=511
#pragma SWIG nowarn=506
