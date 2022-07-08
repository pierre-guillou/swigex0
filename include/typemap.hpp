#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"
#include "VectorT.hpp"
#include "VectorNumT.hpp"

class MYFIBO_EXPORT TypeClass
{
public:
  TypeClass();
  ~TypeClass();

  void setDouble(double varDouble)                           {    _varDouble = varDouble;  }
  void setInt(int varInt)                                    {    _varInt = varInt;  }
  void setString(const String &varString)                    {    _varString = varString;  }
  void setVectorDouble(const VectorDouble &varVectorDouble)  {    _varVectorDouble = varVectorDouble;  }
  void setVectorInt(const VectorInt &varVectorInt)           {    _varVectorInt = varVectorInt;  }
  void setVectorString(const VectorString &varVectorString)  {    _varVectorString = varVectorString;  }

  double getDouble() const                                   {    return _varDouble;  }
  int getInt() const                                         {    return _varInt;  }
  const String& getString() const                            {    return _varString;  }
  const VectorDouble& getVectorDouble() const                {    return _varVectorDouble;  }
  const VectorInt& getVectorInt() const                      {    return _varVectorInt;  }
  const VectorString& getVectorString() const                {    return _varVectorString;  }

private:
  int          _varInt;
  double       _varDouble;
  String       _varString;
  VectorInt    _varVectorInt;
  VectorDouble _varVectorDouble;
  VectorString _varVectorString;
};
