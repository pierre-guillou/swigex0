%module(directors="1") myfibo

// Note : Keep order in this file!

//////////////////////////////////////////////////////////////
//    Specific typemaps and fragments for Python language   //
//////////////////////////////////////////////////////////////

// TODO : Handle undefined or NA values

%fragment("Conversions", "header", fragment="SWIG_AsVal_std_string")
{
  template <typename Type>
  int convertObject(PyObject* obj, Type& value);
  
  template <>
  int convertObject(PyObject* obj, int& value)
  {
    return SWIG_AsVal_int(obj, &value);;
  }
  
  template <>
  int convertObject(PyObject* obj, double& value)
  {
    return SWIG_AsVal_double(obj, &value);
  }
  
  template <>
  int convertObject(PyObject* obj, String& value)
  {
    return SWIG_AsVal_std_string(obj, &value);
  }
}

%fragment("ToVectorT", "header")
{
  template <typename Vector>
  int fillVector(PyObject* obj, Vector& vec) // Using PyObject
  {
    auto myvec = vec.getVectorPtr();
    int res = swig::asptr(obj, &myvec);
    // So we copy the vector
    // TODO : reserve
    if (SWIG_IsOK(res))
    {
      for (const auto& i: *myvec)
      {
        vec.push_back(i);
      }
    }
    return res;
  }
}

%typemap(in, fragment="Conversions") int,
                                     double//,
//                                     String
{
  const int errcode = convertObject($input, $1);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
}

%typemap(in, fragment="Conversions") const int&    (int val),
                                     const int*    (int val),
                                     const double& (double val), 
                                     const double* (double val)//, 
//                                     const String& (String val),
//                                     const String* (String val)
{
  const int errcode = convertObject($input, val);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
  $1 = &val;
}

//////////////////////////////////////////////////////////////
//         C++ library SWIG includes and typemaps           //
//////////////////////////////////////////////////////////////

%include ../swig/swig_inc.i

//////////////////////////////////////////////////////////////
//                C++ library SWIG interface                //
//////////////////////////////////////////////////////////////

%include ../swig/swig_exp.i

///////////////////////////////////////////////////////////
//     Add target language additional features below     //
///////////////////////////////////////////////////////////


