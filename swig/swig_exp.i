// Sensitive file ! Keep Order

// Global files to be wrapped from C++ library
// Remind that swig %include doesn't follow #include inclusion.
// You must cite below each single header file that you want to export!
// Put low level headers in first positions (otherwise Syntax error in input(1).)
%include myfibo_export.hpp // Do not forget this file in priority (for SWIG preprocessor)
%include fibo_define.hpp
%include fibo.hpp
%include args.hpp
%include polymorph.hpp
%include stdoutredirect.hpp

// For suppressing SWIG warning due to -keyword option (if used)
#pragma SWIG nowarn=511
#pragma SWIG nowarn=506

