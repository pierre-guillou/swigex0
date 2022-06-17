#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"

/// Global functions
MYFIBO_EXPORT int fibn(int n);
MYFIBO_EXPORT VectorInt fib(int n);

/**
 * Class which handles Fibonacci integers list
 */
class MYFIBO_EXPORT Fibo
{
  public:
    Fibo (int n, const String& title = "");
    virtual ~Fibo();

    void display(bool showTitle = true) const;

    VectorInt get() const;

  protected:
    int    _n;     /// Maximum integer of the list
    String _title; /// Title to be shown when displaying the list
};

