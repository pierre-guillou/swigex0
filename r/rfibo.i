%module(directors="1") myfibo

// Note : Keep order in this file!

//////////////////////////////////////////////////////////////
//       Specific typemaps and fragments for R language     //
//////////////////////////////////////////////////////////////

// TODO : Handle undefined or NA values

%fragment("Conversions", "header", fragment="SWIG_AsVal_std_string")
{
  template <typename Type>
  int convertObject(SEXP obj, Type& value);
  
  template <>
  int convertObject(SEXP obj, int& value)
  {
    return SWIG_AsVal_int(obj, &value);;
  }
  
  template <>
  int convertObject(SEXP obj, double& value)
  {
    return SWIG_AsVal_double(obj, &value);
  }
  
  template <>
  int convertObject(SEXP obj, String& value)
  {
    return SWIG_AsVal_std_string(obj, &value);
  }
}

%fragment("ToVectorT", "header")
{
  template <typename Vector>
  int fillVector(SEXP obj, Vector& vec) // Using SEXP
  {
    auto myvec = vec.getVectorPtr();
    int res = swig::asptr(obj, &myvec);
    // So we copy the vector
    // TODO : reserve
    if (SWIG_IsOK(res))
      for (const auto& i: *myvec)
        vec.push_back(i);
    return res;
  }
}

%typemap(scoerceout) int,    int*,    int&,
                     double, double*, double&,
                     String, String*, String&
 %{    %}

%typemap(scoerceout) VectorInt,    VectorInt*,    VectorInt&,
                     VectorDouble, VectorDouble*, VectorDouble&,
                     VectorString, VectorString*, VectorString&
 %{    %}

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

// TODO : Redirection of std::cout for windows RGui.exe users
