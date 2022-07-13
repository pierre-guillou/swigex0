// Sensitive file ! Keep Order

// Cast strings into native type of the target language
%include std_string.i

// Global files to be wrapped from myfibo library
%include myfibo_export.hpp // Do not forget this file in priority (for SWIG preprocessor)
%include fibo_define.hpp

// Cast our template vectors with scalar types
%include VectorT.hpp
%include VectorNumT.hpp
%template(VectorString) VectorT<std::string>;
%template(VectorInt)    VectorNumT<int>;
%template(VectorDouble) VectorNumT<double>;

// Rest of the header files from myfibo library
%include fibo.hpp
%include args.hpp
%include polymorph.hpp
%include typemap.hpp
%include stdoutredirect.hpp

// For suppressing SWIG warning due to -keyword option (if used)
#pragma SWIG nowarn=511
#pragma SWIG nowarn=506

