#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"

/**
 * Base class for testing polymorphism in target language
 */
class MYFIBO_EXPORT AParent
{
  public:
    AParent() {};
    virtual ~AParent() {};

    virtual String getHello() const { return "Hello"; }
};

/**
 * Concrete class for testing polymorphism in target language
 */
class MYFIBO_EXPORT ChildOne : public AParent
{
  public:
    ChildOne() {};
    virtual ~ChildOne() {};

    virtual String getHello() const override { return "ChildOne - Hello"; }
};

/// Global function for testing polymorphism
MYFIBO_EXPORT void showHello(AParent* parent);


