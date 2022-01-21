#pragma once

#include <vector>
#include <string>

/// Global function
std::vector<int> fib(int n);

/**
 * Class which handles Fibonacci integers serie
 */
class Fibo
{
  public:
    Fibo (int n, const std::string& title = "");
    ~Fibo();
    
    void display(bool showTitle = true) const;
    
    std::vector<int> get() const;
  
  private:
    int         _n;     /// Maximum integer for the serie
    std::string _title; /// Title to be displayed when displaying the serie
};

