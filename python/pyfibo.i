%module(directors="1") myfibo

// Note : Keep order in this file!

//////////////////////////////////////////////////////////////
//    Specific typemaps and fragments for Python language   //
//////////////////////////////////////////////////////////////

// TODO : Handle undefined or NA values

%fragment("Conversions", "header")
{
  template <typename Type>
  int convert2cpp(PyObject* obj, Type& value);
  
  template <>
  int convert2cpp(PyObject* obj, int& value)
  {
    return SWIG_AsVal_int(obj, &value);
  }
  
  template <>
  int convert2cpp(PyObject* obj, double& value)
  {
    return SWIG_AsVal_double(obj, &value);
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


