#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"
#include "VectorNumT.hpp"

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

    void resetFromFiboVal(Fibo fib);        // In order to test class argument as value
    void resetFromFiboRef(const Fibo& fib); //  In order to test class argument as reference

    void display(bool showTitle = true) const;

    VectorInt get() const;

  protected:
    int    _n;     /// Maximum integer of the list
    String _title; /// Title to be shown when displaying the list
};

