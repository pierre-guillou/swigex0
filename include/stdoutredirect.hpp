#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"

#include <fstream>

// Standard output stream redirection

class MYFIBO_EXPORT StdoutRedirect {
public:
  StdoutRedirect(const String& file = "");
  ~StdoutRedirect();
  StdoutRedirect(const StdoutRedirect&) = delete;
  StdoutRedirect& operator=(const StdoutRedirect&) = delete;

  void start(const String& file);
  void stop();

private:
#if defined(_WIN32) || defined(_WIN64)
  // HANDLE _old_stdout;
  void* _old_stdout;
#else
  std::streambuf* _coutbuf;
  std::ofstream _out;
#endif
};
