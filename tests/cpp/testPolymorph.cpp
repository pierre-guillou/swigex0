#include "polymorph.hpp"
#include "stdoutredirect.hpp"

#include <iostream>

class ChildTwo : public AParent
{
public:
  ChildTwo(): AParent() {}
  virtual ~ChildTwo() {}

  virtual String getHello() const override
  {
    return "ChildTwo in C++ - Hello";
  }
};

int main()
{
  StdoutRedirect sr("testPolymorph.out");
  
  AParent ap;
  showHello(&ap);
  ChildOne co;
  showHello(&co);
  ChildTwo ct;
  showHello(&ct);

  return 0;
}
