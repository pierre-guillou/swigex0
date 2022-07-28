%module(directors="1") myfibo

// Note : Keep order in this file!

//////////////////////////////////////////////////////////////
//    Specific typemaps and fragments for Python language   //
//////////////////////////////////////////////////////////////

%fragment("ToCpp", "header")
{
  int isNumericVector(PyObject* obj)
  {
    if (PySequence_Check(obj) || PyArray_CheckExact(obj))
    {
      int size = (int)PySequence_Length(obj);
      for (int i = 0; i < size; ++i)
      {
        PyObject* item = PySequence_GetItem(obj, i);
        if (!PyNumber_Check(item))
          return SWIG_TypeError;
      }
      return SWIG_OK;
    }
    return SWIG_TypeError;
  }
  int isStringVector(PyObject* obj)
  {
    if (PySequence_Check(obj) || PyArray_CheckExact(obj))
    {
      // TODO : PyString_Check doesn't return true ?
      //int size = (int)PySequence_Length(obj);
      //for (int i = 0; i < size; ++i)
      //{
      //  PyObject* item = PySequence_GetItem(obj, i);
      //  if (!PyString_Check(item))
      //    return SWIG_TypeError;
      //}
      return SWIG_OK;
    }
    return SWIG_TypeError;
  }

  template <typename Type> int convertToCpp(PyObject* obj, Type& value);
  
  template <> int convertToCpp(PyObject* obj, int& value)
  {
    // TODO : Handle undefined or NA values
    // TODO : SWIG_AsVal_int fails when PyObject is a NumPy Array item!
    return SWIG_AsVal_int(obj, &value);
  }
  template <> int convertToCpp(PyObject* obj, double& value)
  {
    // TODO : Handle undefined or NA values
    return SWIG_AsVal_double(obj, &value);
  }
  template <> int convertToCpp(PyObject* obj, String& value)
  {
    // No undefined
    return SWIG_AsVal_std_string(obj, &value);
  }
  
  template <typename Vector>
  int vectorToCpp(PyObject* obj, Vector& vec)
  {
    // Type definitions
    using ValueType = typename Vector::value_type;
    
    // Conversion
    vec.clear();
    int myres = SWIG_OK;
    int size = (int)PySequence_Length(obj);
    if (size < 0)
    {
      // Not a sequence (maybe a single value ?)
      ValueType value;
      // Clear Python error indicator
      PyErr_Restore(NULL, NULL, NULL);
      // Try to convert
      myres = convertToCpp(obj, value);
      if (SWIG_IsOK(myres))
        vec.push_back(value);
    }
    else if (size > 0)
    {
      // Real sequence 
      vec.reserve(size);
      for (int i = 0; i < size && SWIG_IsOK(myres); i++)
      {
        PyObject* item = PySequence_GetItem(obj, i);
        ValueType value;
        myres = convertToCpp(item, value);
        if (SWIG_IsOK(myres))
          vec.push_back(value);
      }
    }
    return myres;
  }

  template <typename VectorVector>
  int vectorVectorToCpp(PyObject* obj, VectorVector& vvec)
  {
    // Type definitions
    using InputVector = typename VectorVector::value_type;
    
    // Conversion
    vvec.clear();
    int myres = SWIG_OK;
    int size = (int)PySequence_Length(obj);
    if (size < 0)
    {
      // Not a sequence
      InputVector vec;
      // Clear Python error indicator
      PyErr_Restore(NULL, NULL, NULL);
      // Try to convert
      myres = vectorToCpp(obj, vec);
      if (SWIG_IsOK(myres))
        vvec.push_back(vec);
    }
    else if (size > 0)
    {
      for (int i = 0; i < size && SWIG_IsOK(myres); i++)
      {
        PyObject* item = PySequence_GetItem(obj, i);
        InputVector vec;
        myres = vectorToCpp(item, vec);
        if (SWIG_IsOK(myres))
          vvec.push_back(vec);
      }
    }
    return myres;
  }
}

// Add numerical vector typecheck typemaps for dispatching functions
%typemap(typecheck, noblock=1, fragment="ToCpp", precedence=SWIG_TYPECHECK_DOUBLE_ARRAY) const VectorInt&,    VectorInt,
                                                                                         const VectorDouble&, VectorDouble
{
  $1 = SWIG_CheckState(isNumericVector($input));
}

// Add generic vector typecheck typemaps for dispatching functions
%typemap(typecheck, noblock=1, fragment="ToCpp", precedence=SWIG_TYPECHECK_STRING_ARRAY) const VectorString&, VectorString
{
  $1 = SWIG_CheckState(isStringVector($input));
}

// Include numpy interface for creating arrays

%{
  #define SWIG_FILE_WITH_INIT
%}
%include numpy.i
%init %{
  import_array(); // Mandatory for using PyArray_* functions
%}

%fragment("FromCpp", "header")
{
  template <typename Type> NPY_TYPES numpyType();
  template <> NPY_TYPES numpyType<int>()    { return NPY_INT; }
  template <> NPY_TYPES numpyType<double>() { return NPY_DOUBLE; }
  template <> NPY_TYPES numpyType<String>() { return NPY_STRING; }
  
  template<typename Type> struct TypeHelper;
  template <> struct TypeHelper<int>    { static bool hasFixedSize() { return true; } };
  template <> struct TypeHelper<double> { static bool hasFixedSize() { return true; } };
  template <> struct TypeHelper<String> { static bool hasFixedSize() { return false; } };
  template <typename Type> bool hasFixedSize() { return TypeHelper<Type>::hasFixedSize(); }
  
  template <typename InputType> struct OutTraits; // Only used for fixed item size
  template <> struct OutTraits<int>    { using OutputType = int; };
  template <> struct OutTraits<double> { using OutputType = double; };
  template <> struct OutTraits<String> { using OutputType = String; };
  template <typename Type> typename OutTraits<Type>::OutputType convertFromCpp(Type value);
  template <> int convertFromCpp(int value)
  {
    // TODO : handle undefined or NA values
    return value;
  }
  template <> double convertFromCpp(double value)
  {
    // TODO : handle undefined or NA values
    return value;
  }
  template <> String convertFromCpp(String value)
  {
    return value; // No special conversion provided
  }
  
  template <typename Vector>
  int vectorFromCpp(PyObject** obj, const Vector& vec)
  {
    // Type definitions
    int myres = SWIG_TypeError;
    using SizeType = typename Vector::size_type;
    using InputType = typename Vector::value_type;
    
    // Conversion
    if (hasFixedSize<InputType>()) // Convert to 1D NumPy array
    {
      using OutputType = typename OutTraits<InputType>::OutputType;
      SizeType size = vec.size();
      npy_intp dims[1] = { (npy_intp)size };
      //*obj = PyArray_SimpleNew(1, dims, numpyType<InputType>());
      PyArray_Descr* descr = PyArray_DescrFromType(numpyType<InputType>());
      *obj = PyArray_NewFromDescr(&PyArray_Type, descr, 1, dims, NULL, NULL, 0, NULL);
      if (*obj != NULL)
      {
        OutputType* array_ptr = (OutputType*) PyArray_DATA((PyArrayObject*)(*obj));
        std::transform(vec.cbegin(), vec.cend(), array_ptr, convertFromCpp<InputType>);
        myres = SWIG_OK;
      }
    }
    else // Convert to a tuple
    {
      *obj = swig::from(vec.getVector());
      myres = (*obj) == NULL ? SWIG_TypeError : SWIG_OK;
    }
    return myres;
  }

  template <typename VectorVector>
  int vectorVectorFromCpp(PyObject** obj, const VectorVector& vec)
  {
    // Type definitions
    int myres = SWIG_TypeError;
    using SizeType = typename VectorVector::size_type;
    using VectorType = typename VectorVector::value_type;
    using InputType = typename VectorType::value_type;
    using OutputType = typename OutTraits<InputType>::OutputType;

    // Check if empty
    if (vec.empty())
    {
      VectorType v; // Create an empty 1D NumPy array
      return vectorFromCpp(obj, v);
    }
    
    // Check the size of sub-vectors
    bool same_size = true;
    SizeType size = vec.at(0).size();
    for(auto v : vec)
    {
      if (same_size)
        same_size = (v.size() == size);
    }
    
    // Conversion
    if (same_size && hasFixedSize<InputType>()) // Convert to a 2D NumPy array
    {
      SizeType size2 = vec.size();
      npy_intp dims[2] = { (npy_intp)size2, (npy_intp)size };
      *obj = PyArray_SimpleNew(2, dims, numpyType<InputType>());
      if (*obj != NULL)
      {
        OutputType* array_ptr = (OutputType*) PyArray_DATA((PyArrayObject*)(*obj));
        for (auto v : vec)
        {
          std::transform(v.cbegin(), v.cend(), array_ptr, convertFromCpp<InputType>);
          array_ptr += size;
        }
        myres = SWIG_OK;
      }
    }
    else // Convert to a list of 1D NumPy array (fixed item size) or tuple (no item size)
    {
      // https://stackoverflow.com/questions/36050713/using-py-buildvalue-to-create-a-list-of-tuples-in-c
      *obj = PyList_New(0);
      if(*obj != NULL)
      {
        myres = SWIG_OK;
        const unsigned int size = vec.size();
        for(unsigned int i = 0; i < size && SWIG_IsOK(myres); i++)
        {
          PyObject* tuple;
          myres = vectorFromCpp(&tuple, vec.at(i));
          if (SWIG_IsOK(myres))
            myres = PyList_Append(*obj, tuple);
        }
      }
    }
    
    return myres;
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

//////////////////////////////////////////////////////////////
//                    Add C++ extension                     //
//////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////
//       Add target language additional features below      //
//////////////////////////////////////////////////////////////

// Make VectorXXX python class subscriptable

%pythoncode %{
  import myfibo as mf
  def setitem(self, idx, item):
    if idx < 0 or idx >= self.length():
      raise IndexError("Index out or range")
    self.set(idx,item)
    
  def getitem(self, idx):
    if idx < 0 or idx >= self.length():
      raise IndexError("Index out or range")
    return self.get(idx)

  setattr(mf.VectorDouble,      "__getitem__", getitem)
  setattr(mf.VectorDouble,      "__setitem__", setitem)
  setattr(mf.VectorInt,         "__getitem__", getitem)
  setattr(mf.VectorInt,         "__setitem__", setitem)
  setattr(mf.VectorString,      "__getitem__", getitem)
  setattr(mf.VectorString,      "__setitem__", setitem)
  setattr(mf.VectorVectorDouble,"__getitem__", getitem)
  setattr(mf.VectorVectorDouble,"__setitem__", setitem)
  setattr(mf.VectorVectorInt,   "__getitem__", getitem)
  setattr(mf.VectorVectorInt,   "__setitem__", setitem)
%}