#pragma once

#include "swigex_export.hpp"
#include "swigex_define.hpp"

/**
 * Base class for testing polymorphism in target language
 */
class SWIGEX_EXPORT AParent
{
  public:
    AParent() {};
    virtual ~AParent() {};

    virtual String getHello() const { return "Hello"; }
};

/**
 * Concrete class for testing polymorphism in target language
 */
class SWIGEX_EXPORT ChildOne : public AParent
{
  public:
    ChildOne() {};
    virtual ~ChildOne() {};

    virtual String getHello() const override { return "ChildOne - Hello"; }
};

/// Global function for testing polymorphism
SWIGEX_EXPORT void showHello(AParent* parent);


