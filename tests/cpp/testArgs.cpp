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
  if (i != 12)
    std::cout << "Wrong Int!" << std::endl;
  i = testIntPtr(new int(22));
  if (i != 22)
    std::cout << "Wrong Int Pointer!" << std::endl;
  int* pi = testIntCreate(32);
  if (*pi != 32)
    std::cout << "Wrong Int Create!" << std::endl;
  VectorInt vi = testVectorInt({23,33,43});
  if (vi[0] != 23 || vi[1] != 33 || vi[2] != 43)
    std::cout << "Wrong VectorInt!" << std::endl;
  vi = testVectorIntPtr(new VectorInt({24,34,44}));
  if (vi[0] != 24 || vi[1] != 34 || vi[2] != 44)
    std::cout << "Wrong VectorInt Pointer!" << std::endl;
  VectorInt* pvi = testVectorIntCreate({25,35,45});
  if (pvi->at(0) != 25 || pvi->at(1) != 35 || pvi->at(2) != 45)
    std::cout << "Wrong VectorInt Create!" << std::endl;
  String s = testString("Str12");
  if (s != "Str12")
    std::cout << "Wrong String!" << std::endl;
  s = testStringPtr(new String("Str22"));
  if (s != "Str22")
    std::cout << "Wrong String Pointer!" << std::endl;
  String* ps = testStringCreate("Str32");
  if (*ps != "Str32")
    std::cout << "Wrong String Create!" << std::endl;
  VectorString vs = testVectorString({"Str23","Str33","Str43"});
  if (vs[0] != "Str23" || vs[1] != "Str33" || vs[2] != "Str43")
    std::cout << "Wrong VectorString!" << std::endl;
  vs = testVectorStringPtr(new VectorString({"Str24","Str34","Str44"}));
  if (vs[0] != "Str24" || vs[1] != "Str34" || vs[2] != "Str44")
    std::cout << "Wrong VectorString Pointer!" << std::endl;
  VectorString* pvs = testVectorStringCreate({"Str25","Str35","Str45"});
  if (pvs->at(0) != "Str25" || pvs->at(1) != "Str35" || pvs->at(2) != "Str45")
    std::cout << "Wrong VectorString Create!" << std::endl;

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
