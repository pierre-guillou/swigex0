#pragma once

// Do not use cmake GenerateExportHeader which is not adapted to double targets (static/shared)
#if defined(_WIN32) || defined (__CYGWIN__) // Windows
#  ifdef MYFIBO_BUILD_SHARED // Shared export
#    pragma message("We are compiling the shared library")
#    define MYFIBO_EXPORT __declspec(dllexport)
#  else
#    ifdef MYFIBO_IMPORT_SHARED // Shared import
#      pragma message("We are importing the shared library")
#      define MYFIBO_EXPORT __declspec(dllimport)
#    else 
#      ifdef MYFIBO_BUILD_STATIC // Static export
#        pragma message("We are compiling the static library")
#      else // Static import
#        pragma message("We are importing the static library")
#      endif
#      define MYFIBO_EXPORT 
#    endif
#  endif
#else // Linux
#  if defined(MYFIBO_BUILD_SHARED) || defined (MYFIBO_IMPORT_SHARED)
#    define MYFIBO_EXPORT __attribute__((visibility("default")))
#  else
#    define MYFIBO_EXPORT 
#  endif
// else TODO MacOS
#endif

#ifdef SWIG
#  undef MYFIBO_EXPORT 
#  define MYFIBO_EXPORT 
#endif
