%module(directors="1") myfibo

// Note : Keep order in this file!

//////////////////////////////////////////////////////////////
//    Specific typemaps and fragments for Python language   //
//////////////////////////////////////////////////////////////

// TODO : Handle undefined or NA values

%fragment("ToCpp", "header")
{
  template <typename Type>
  int convertToCpp(PyObject* obj, Type& value);
  
  template <>
  int convertToCpp(PyObject* obj, int& value)
  {
    return SWIG_AsVal_int(obj, &value);
  }
  
  template <>
  int convertToCpp(PyObject* obj, double& value)
  {
    return SWIG_AsVal_double(obj, &value);
  }
  
  template <typename Vector>
  int vectorToCpp(PyObject* obj, Vector& vec) // Using PyObject
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
  
  template <typename VectorVector>
  int vectorVectorToCpp(PyObject* obj, VectorVector& vvec) // Using PyObject
  {
    using InputVector = typename VectorVector::value_type;
    int res = 0;
    const int nvalues = (int)PySequence_Length(obj);
    for (int i = 0; i < nvalues; ++i)
    {
      PyObject* item = PySequence_GetItem(obj, i);
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
  int vectorFromCpp(PyObject** obj, const Vector& vec) // Using PyObject
  {
    *obj = swig::from(vec.getVector());
    return (*obj) == NULL ? -1 : 0;
  }

  template <typename VectorVector>
  int vectorVectorFromCpp(PyObject** obj, const VectorVector& vec) // Using PyObject  
  {
    int res = -1;
    // https://stackoverflow.com/questions/36050713/using-py-buildvalue-to-create-a-list-of-tuples-in-c
    *obj = PyList_New(0);
    if(*obj != NULL)
    {
      res = 0;
      const unsigned int size = vec.size();
      for(unsigned int i = 0; i < size && res == 0; i++)
      {
        PyObject* tuple;
        res = vectorFromCpp(&tuple, vec.at(i));
        if (res == 0)
          res = PyList_Append(*obj, tuple);
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


