#include "args.hpp"

#include <iostream>
#include <fstream>

#if defined(_WIN32) || defined(_WIN64)
#  include <windows.h>
#  include <io.h>
#  include <fcntl.h>
#endif

int main()
{
  String file = "testArgs.out";
  
#ifdef _WIN32
  // https://stackoverflow.com/questions/54094127/redirecting-stdout-in-win32-does-not-redirect-stdout/54096218
  void* old_stdout = GetStdHandle(STD_OUTPUT_HANDLE);
  HANDLE new_stdout = CreateFileA(file.c_str(), GENERIC_WRITE, FILE_SHARE_READ, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
  SetStdHandle(STD_OUTPUT_HANDLE, new_stdout);
  int fd = _open_osfhandle((intptr_t)new_stdout, _O_WRONLY|_O_TEXT);
  _dup2(fd, _fileno(stdout));
  _close(fd);
#else
  std::streambuf* coutbuf;
  coutbuf = std::cout.rdbuf();
  std::ofstream out;
  out.open(file, std::fstream::out | std::fstream::trunc);
  std::cout.rdbuf(out.rdbuf());
#endif

  int i = testInt(12);
  if (i != 12) return 1;
  VectorInt vi = testVectorInt({23,33,43});
  if (vi[0] != 23 || vi[1] != 33 || vi[2] != 43) return 1;
  String s = testString("Str12");
  if (s != "Str12") return 1;
  VectorString vs = testVectorString({"Str23","Str33","Str43"});
  if (vs[0] != "Str23" || vs[1] != "Str33" || vs[2] != "Str43") return 1;
  
#ifdef _WIN32
  // https://stackoverflow.com/questions/32185512/output-to-console-from-a-win32-gui-application-on-windows-10
  SetStdHandle(STD_OUTPUT_HANDLE, old_stdout);
  fd = _open_osfhandle((intptr_t)old_stdout, _O_WRONLY|_O_TEXT);
  FILE* fp = _fdopen(fd, "w");
  freopen_s( &fp, "CONOUT$", "w", stdout);
#else
  std::cout.rdbuf(coutbuf);
  out.close();
#endif
  
  return 0;
}
