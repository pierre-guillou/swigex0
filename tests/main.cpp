#include <fibo.hpp>

int main()
{
  std::vector<int> vec = fib(50);
  Fibo f(50);
  f.display();
  return 0;
}
