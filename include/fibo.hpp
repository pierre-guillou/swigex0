#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"

/// Global functions
MYFIBO_EXPORT int fibn(int n);
MYFIBO_EXPORT VectorInt fib(int n);

/**
 * Class which handles Fibonacci integers serie
 */
class MYFIBO_EXPORT Fibo
{
  public:
    Fibo (int n, const String& title = "");
    ~Fibo();
    
    void display(bool showTitle = true) const;
    
    VectorInt get() const;
  
  private:
    int    _n;     /// Maximum integer for the serie
    String _title; /// Title to be displayed when displaying the serie
};

