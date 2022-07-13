#include "args.hpp"
#include "stdoutredirect.hpp"

#include <iostream>

int main()
{
  StdoutRedirect sr("testArgs.out");
  
  TypeClass a;
  int i = a.testInt(12);
  if (i != 12)
    std::cout << "Wrong Int!" << std::endl;
  i = a.testIntRef(22);
  if (i != 22)
    std::cout << "Wrong Int Reference!" << std::endl;
  const int* pi = a.testIntPtr(new int(32));
  if ((*pi) != 32)
    std::cout << "Wrong Int Pointer!" << std::endl;
  VectorInt vi = a.testVectorInt({23,33,43});
  if (vi[0] != 23 || vi[1] != 33 || vi[2] != 43)
    std::cout << "Wrong VectorInt!" << std::endl;
  vi = a.testVectorIntRef({24,34,44});
  if (vi[0] != 24 || vi[1] != 34 || vi[2] != 44)
    std::cout << "Wrong VectorInt Reference!" << std::endl;
  const VectorInt* pvi = a.testVectorIntPtr(new VectorInt({25,35,45}));
  if ((*pvi)[0] != 25 || (*pvi)[1] != 35 || (*pvi)[2] != 45)
    std::cout << "Wrong VectorInt Pointer!" << std::endl;
  double d = a.testDouble(12.1);
  if (d != 12.1)
    std::cout << "Wrong Double!" << std::endl;
  d = a.testDoubleRef(22.2);
  if (d != 22.2)
    std::cout << "Wrong Double Reference!" << std::endl;
  const double* pd = a.testDoublePtr(new double(32.3));
  if ((*pd) != 32.3)
    std::cout << "Wrong Double Pointer!" << std::endl;
  VectorDouble vd = a.testVectorDouble({23.1,33.1,43.1});
  if (vd[0] != 23.1 || vd[1] != 33.1 || vd[2] != 43.1)
    std::cout << "Wrong VectorDouble!" << std::endl;
  vd = a.testVectorDoubleRef({24.2,34.2,44.2});
  if (vd[0] != 24.2 || vd[1] != 34.2 || vd[2] != 44.2)
    std::cout << "Wrong VectorDouble Reference!" << std::endl;
  const VectorDouble* pvd = a.testVectorDoublePtr(new VectorDouble({25.3,35.3,45.3}));
  if ((*pvd)[0] != 25.3 || (*pvd)[1] != 35.3 || (*pvd)[2] != 45.3)
    std::cout << "Wrong VectorDouble Pointer!" << std::endl;
  String s = a.testString("Str12");
  if (s != "Str12")
    std::cout << "Wrong String!" << std::endl;
  s = a.testStringRef("Str22");
  if (s != "Str22")
    std::cout << "Wrong String Reference!" << std::endl;
  const String* ps = a.testStringPtr(new String("Str32"));
  if ((*ps) != "Str32")
    std::cout << "Wrong String Pointer!" << std::endl;
  VectorString vs = a.testVectorString({"Str23","Str33","Str43"});
  if (vs[0] != "Str23" || vs[1] != "Str33" || vs[2] != "Str43")
    std::cout << "Wrong VectorString!" << std::endl;
  vs = a.testVectorStringRef({"Str24","Str34","Str44"});
  if (vs[0] != "Str24" || vs[1] != "Str34" || vs[2] != "Str44")
    std::cout << "Wrong VectorString Reference!" << std::endl;
  const VectorString* pvs = a.testVectorStringPtr(new VectorString({"Str25","Str35","Str45"}));
  if ((*pvs)[0] != "Str25" || (*pvs)[1] != "Str35" || (*pvs)[2] != "Str45")
    std::cout << "Wrong VectorString Pointer!" << std::endl;

  return 0;
}
