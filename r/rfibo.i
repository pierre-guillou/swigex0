%module(directors="1") myfibo

// Note : Keep order in this file!

//////////////////////////////////////////////////////////////
//       Specific typemaps and fragments for R language     //
//////////////////////////////////////////////////////////////

%fragment("ToCpp", "header")
{
  template <typename Type>
  int convertToCpp(SEXP obj, Type& value);
  
  template <>
  int convertToCpp(SEXP obj, int& value)
  {
    // TODO : Handle undefined or NA values
    return SWIG_AsVal_int(obj, &value);
  }
  
  template <>
  int convertToCpp(SEXP obj, double& value)
  {
    // TODO : Handle undefined or NA values
    return SWIG_AsVal_double(obj, &value);
  }

  template <typename Vector>
  int vectorToCpp(SEXP obj, Vector& vec)
  {
    auto myvec = vec.getVectorPtr();
    int myres = swig::asptr(obj, &myvec);
    // So we copy the vector
    // TODO : reserve
    if (SWIG_IsOK(myres))
      for (const auto& i: *myvec)
        vec.push_back(i);
    return myres;
  }
  
  template <typename VectorVector>
  int vectorVectorToCpp(SEXP obj, VectorVector& vvec)
  {
    using InputVector = typename VectorVector::value_type;
    int myres = SWIG_OK;
    const int nvalues = (int)Rf_length(obj);
    for (int i = 0; i < nvalues; ++i)
    {
      SEXP item = VECTOR_ELT(obj, i);
      InputVector vec;
      myres = vectorToCpp(item, vec);
      if (SWIG_IsOK(myres))
        vvec.push_back(vec);
      else
        break;
    }
    return myres;
  }
}


%fragment("FromCpp", "header")
{
  template <typename Vector>
  int vectorFromCpp(SEXP* obj, const Vector& vec)
  {
    // TODO : handle empty vectors
    *obj = swig::from(vec.getVector());
    return (*obj) == NULL ? -1 : 0;
  }

  template <typename VectorVector>
  int vectorVectorFromCpp(SEXP* obj, const VectorVector& vec)
  {
    // TODO : handle empty vectors
    int myres = SWIG_TypeError;
    // https://cpp.hotexamples.com/examples/-/-/Rf_allocVector/cpp-rf_allocvector-function-examples.html
    const unsigned int size = vec.size();
    *obj = Rf_allocVector(VECSXP, size);
    if(*obj != NULL)
    {
      myres = SWIG_OK;
      for(unsigned int i = 0; i < size && SWIG_IsOK(myres); i++)
      {
        SEXP rvec;
        myres = vectorFromCpp(&rvec, vec.at(i));
        if (SWIG_IsOK(myres))
          SET_VECTOR_ELT(*obj, i, rvec);
      }
    }
    
    return myres;
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
