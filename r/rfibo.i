%module(directors="1") myfibo

// Note : Keep order in this file!

//////////////////////////////////////////////////////////////
//       Specific typemaps and fragments for R language     //
//////////////////////////////////////////////////////////////

// TODO : Handle undefined or NA values

%fragment("ToCpp", "header")
{
  template <typename Type>
  int convertToCpp(SEXP obj, Type& value);
  
  template <>
  int convertToCpp(SEXP obj, int& value)
  {
    return SWIG_AsVal_int(obj, &value);
  }
  
  template <>
  int convertToCpp(SEXP obj, double& value)
  {
    return SWIG_AsVal_double(obj, &value);
  }

  template <typename Vector>
  int vectorToCpp(SEXP obj, Vector& vec) // Using SEXP
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
  
  template <typename VectorVector>
  int vectorVectorToCpp(SEXP obj, VectorVector& vvec) // Using SEXP
  {
    using InputVector = typename VectorVector::value_type;
    int res = 0;
    const int nvalues = (int)Rf_length(obj);
    for (int i = 0; i < nvalues; ++i)
    {
      SEXP item = VECTOR_ELT(obj, i);
      InputVector vec;
      res = vectorToCpp(item, vec);
      if (SWIG_IsOK(res))
        vvec.push_back(vec);
      else
        break;
    }
    return res;
  }
}


%fragment("FromCpp", "header")
{
  template <typename Vector>
  int vectorFromCpp(SEXP* obj, const Vector& vec) // Using SEXP
  {
    *obj = swig::from(vec.getVector());
    return (*obj) == NULL ? -1 : 0;
  }

  template <typename VectorVector>
  int vectorVectorFromCpp(SEXP* obj, const VectorVector& vec) // Using SEXP
  {
    int res = -1;
    // https://cpp.hotexamples.com/examples/-/-/Rf_allocVector/cpp-rf_allocvector-function-examples.html
    const unsigned int size = vec.size();
    *obj = Rf_allocVector(VECSXP, size);
    if(*obj != NULL)
    {
      res = 0;
      for(unsigned int i = 0; i < size && res == 0; i++)
      {
        SEXP rvec;
        res = vectorFromCpp(&rvec, vec.at(i));
        if (res == 0)
          SET_VECTOR_ELT(*obj, i, rvec);
      }
    }
    
    return res;
  }
}

%typemap(scoerceout) int,    int*,    int&,
                     double, double*, double&
 %{    %}

%typemap(scoerceout) VectorInt,    VectorInt*,    VectorInt&,
                     VectorDouble, VectorDouble*, VectorDouble&,
                     VectorString, VectorString*, VectorString&
 %{    %}

%typemap(scoerceout) VectorVectorInt,    VectorVectorInt*,    VectorVectorInt&,
                     VectorVectorDouble, VectorVectorDouble*, VectorVectorDouble&
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
