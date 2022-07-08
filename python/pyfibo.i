%module(directors="1") myfibo

%include ../swig/swig_inc.i


//////////////////////////////////////////////////////////////
//     Specific SWIG feature for Python target language     //
//////////////////////////////////////////////////////////////

/// TODO : What about using pybind11 in SWIG typemaps ?

%{
  #define SWIG_FILE_WITH_INIT // For numpy.i / import_array usage
%}

%include typemaps.i
%include numpy.i

%init %{
  import_array();
%}

//////////////////////////////////////////////////////////////////////////
// Adapted from pygeos.i (polaris)


/////////////////////
// Sequence check

// TODO : checking sequence to be restored ?
/*
%fragment("SequenceCheck", "header")
{
  int CheckIsNumericSequence(PyObject* obj)
  {
    if (PySequence_Check(obj))
    {
      const int nvalues = (int)PySequence_Length(obj);
      for (int i = 0; i < nvalues; ++i)
      {
        PyObject* item = PySequence_GetItem(obj, i);
        if (!PyNumber_Check(item))
          return SWIG_TypeError;
      }
      return SWIG_OK;
    }
    return SWIG_TypeError;
  }
  int CheckIsDoubleArray(PyObject* obj)
  {
    if (PyArray_Check(obj))
    {
      if ((PyArrayObject*)PyArray_ContiguousFromObject(obj, NPY_DOUBLE, 1, 1))
        return SWIG_OK;
    }
    return SWIG_TypeError;
  }
}
*/


/*
%typemap(typecheck, noblock=1, fragment="SequenceCheck") const VectorDouble&,
                                                               VectorDouble,
                                                         const VectorInt&,
                                                               VectorInt,
                                                         const VectorString&,
                                                               VectorString
{
  $1 = SWIG_CheckState(CheckIsNumericSequence($input));
}
*/


////////////////////////////
// Python => C++

%fragment("ConversionsPy2Cpp", "header", fragment="SWIG_AsVal_std_string")
{
   
  // Use template to avoid implicit conversions
  template <typename Type> int convertObject(PyObject* obj, Type& value);
  
  template <>
  int convertObject(PyObject* obj, int& value)
  {
    const int errcode = SWIG_AsVal_int(obj, &value);
    // TODO : manage undefined values and errcode
    return errcode;
  }
  
  template <>
  int convertObject(PyObject* obj, double& value)
  {
    //GbbGlobal::setToUndef(value);
    const int errcode = SWIG_AsVal_double(obj, &value);
    // TODO : manage undefined values and errcode
    //if (SWIG_IsOK(errcode)) {
    //  if (!GbbGlobal::isFloatValid(value))
    //    GbbGlobal::setToUndef(value);
    //}
    return errcode;
  }
  
  template <>
  int convertObject(PyObject* obj, String& value)
  {
    //GbbGlobal::setToUndef(value);
    const int errcode = SWIG_AsVal_std_string(obj, &value);
    // TODO : manage undefined values and errcode
    //if (SWIG_IsOK(errcode)) {
    //  if (!GbbGlobal::isFloatValid(value))
    //    GbbGlobal::setToUndef(value);
    //}
    return errcode;
  }
}

%fragment("ToVectorT", "header", fragment="ConversionsPy2Cpp")
{
  template <typename Container>
  int fillContainer(PyObject* obj, Container& container)
  {
    using ValueType = typename Container::value_type;
    if (!PySequence_Check(obj))
    {
      return SWIG_TypeError;
    }
  
    const int nvalues = (int)PySequence_Length(obj);
    container.reserve(nvalues);
  
    for (int i = 0; i < nvalues; ++i)
    {
      PyObject* item = PySequence_GetItem(obj, i);
  
      ValueType value;
      const int errcode = convertObject(item, value);
      if (!SWIG_IsOK(errcode))
      {
        return errcode;
      }
  
      container.push_back(value);
    }
  
    return SWIG_OK;
  }
}

// References are considered as pointer hence this typemap presence (a local variable is then used)
%typemap(in, fragment="ToVectorT") const VectorDouble& (VectorDouble container),
                                   const VectorInt&    (VectorInt container),
                                   const VectorString& (VectorString container)
{
  const int errcode = fillContainer($input, container);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
  $1 = &container;
}

%typemap(in, fragment="ConversionsPy2Cpp") double
{
  const int errcode = convertObject($input, $1);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
}

// Coming from https://stackoverflow.com/questions/62119785/python-swig-wrapper-for-c-rvalue-stdstring
//%typemap(in, fragment="SWIG_AsVal_std_string") std::string&& (std::string temp) {
//  int res = SWIG_AsVal_std_string($input, &temp);
//  $1 = &temp;
//}


////////////////////////////
// C++ => Python

%fragment("ConversionsCpp2Py", "header")
{
  template <typename> NPY_TYPES numpyType();
  template <> NPY_TYPES numpyType<double>() { return NPY_DOUBLE; }
  template <> NPY_TYPES numpyType<int>() { return NPY_INT; }
  
  template <typename InputType> struct OutTraits;
  template <> struct OutTraits<double> { using OutputType = double; };
  template <> struct OutTraits<int> { using OutputType = int; };
  
  template <typename Type> typename OutTraits<Type>::OutputType convertValue(Type value);
  template <> double convertValue(double value)
  {
    // TODO : manage undefined values
    //return GbbGlobal::isDefined(value) ? value : GbbNumeric::D_NAN;
    return value;
  }
  template <> int convertValue(int value)
  {
    // TODO : manage undefined values
    //return GbbGlobal::isDefined(value) ? value : -9999;
    return value;
  }
}

%fragment("FromVectorT", "header", fragment="ConversionsCpp2Py")
{
  template <typename Container>
  PyObject* createNumpyArrayFromContainer(const Container& container)
  {
    using InputType = typename Container::value_type;
    using OutputType = typename OutTraits<InputType>::OutputType;
  
    const int nvalues = (const int)container.size();
    npy_intp dims[1] = { nvalues };
    PyObject* object = PyArray_SimpleNew(1, dims, numpyType<InputType>());
    PyArrayObject* array = (PyArrayObject*) object;
    OutputType* array_ptr = (OutputType*) PyArray_DATA(array);
  
    std::transform(container.cbegin(), container.cend(), array_ptr, convertValue<InputType>);
  
    return object;
  }
  
  template <typename Container>
  PyObject* createNumpyArrayFromContainerPtr(Container* container)
  {
    return createNumpyArrayFromContainer(*container);
  }
  
  template <typename Container>
  PyObject* createNumpyArrayFromStringContainer(Container& container)
  {
    const int nvalues = (const int)container.size();
    npy_intp dims[1] = { nvalues };
    // Find maximum size of all strings
    size_t itemsize = 0;
    for (auto s : container)
      if (itemsize < s.size())
        itemsize = s.size();
    // Thanks to https://stackoverflow.com/questions/71947424/c-numpy-how-to-create-non-fixed-width-ndarray-of-strings-from-existing-string-v
    size_t mem_size = container.size()*itemsize;
    // Copy all data into a buffer of char**
    void * mem = PyDataMem_NEW(mem_size);
    size_t cur_index=0;
    for(const auto& val : container)
    {
      for(size_t i = 0; i < itemsize; i++)
      {
        char ch = i < val.size() ? val[i] : 0; // fill with NUL if string too short
        reinterpret_cast<char*>(mem)[cur_index] = ch;
        cur_index++;
      }
    }
    PyObject* object = PyArray_New(&PyArray_Type, 1, dims, NPY_STRING, NULL, mem, itemsize, NPY_ARRAY_OWNDATA, NULL);
    return object;
  }
  
  template <typename Container>
  PyObject* createNumpyArrayFromStringContainerPtr(Container* container)
  {
    return createNumpyArrayFromStringContainer(*container);
  }
}

%typemap(out, noblock=1, fragment="FromVectorT") VectorDouble,  // Do not forget comas !! (swig says nothing !!!)
                                                 VectorInt
{
  $result = createNumpyArrayFromContainer($1);
}

%typemap(out, noblock=1, fragment="FromVectorT") VectorDouble&, // Do not forget comas !! (swig says nothing !!!)
                                                 VectorInt&
{
  $result = createNumpyArrayFromContainerPtr($1);
}

%typemap(out, noblock=1, fragment="FromVectorT") VectorString
{
  $result = createNumpyArrayFromStringContainer($1);
}

%typemap(out, noblock=1, fragment="FromVectorT") VectorString&
{
  $result = createNumpyArrayFromStringContainerPtr($1);
}

%typemap(out, noblock=1, fragment="ConversionsCpp2Py") double
{
  $result = SWIG_From_double(convertValue($1));
}

%typemap(out, noblock=1, fragment="ConversionsCpp2Py") int
{
  $result = SWIG_From_int(convertValue($1));
}


// Coming from https://stackoverflow.com/questions/62119785/python-swig-wrapper-for-c-rvalue-stdstring
//%typemap(out, fragment="SWIG_From_std_string") std::string&& {
//  $result = SWIG_From_std_string(*$1);
//}

// End of adaptation from pygeos.i (polaris)
//////////////////////////////////////////////////////////////////////////


// Put this after typemaps definition !
%include ../swig/swig_exp.i

///////////////////////////////////////////////////////////
//     Add target language additional features below     //
///////////////////////////////////////////////////////////


