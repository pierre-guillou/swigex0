#include "polymorph.hpp"

#include <iostream>

 void showHello(const AParent* parent)
{
  //const AParent* pa = dynamic_cast<const AParent*>(parent->clone());
  //std::cout << pa->getHello() << std::endl;
  //delete pa;
   std::cout << parent->getHello() << std::endl;
}

