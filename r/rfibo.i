%module(directors="1") myfibo

// Note : Keep order in this file!

//////////////////////////////////////////////////////////////
//                C++ library SWIG interface                //
//////////////////////////////////////////////////////////////

%include ../swig/swig_inc.i

//////////////////////////////////////////////////////////////
//        Specific SWIG feature for R target language       //
//////////////////////////////////////////////////////////////

////////////////////////////
// R => C++

%fragment("ToVectorT", "header")
{
  template <typename Container>
  int fillContainer(SEXP obj, Container& container)
  {
    auto myvec = container.getVectorPtr();
    int res = swig::asptr(obj, &myvec);
    // TODO : same as pyfibo.i
    // So we copy the vector
    // TODO : reserve
    if (SWIG_IsOK(res))
      for (const auto& i: *myvec)
        container.push_back(i);
    return res;
  }
}

//%typemap_traits_ptr(SWIG_TYPECHECK_VECTOR, VectorInt);
//%traits_type_name(VectorInt);
//%typemap("rtypecheck") VectorInt, VectorInt*, VectorInt&
//   %{ is.integer($arg) || is.numeric($arg) %}
//%typemap("rtype") VectorInt "integer"
//%typemap("scoercein") VectorInt, VectorInt*, VectorInt& "$input = as.integer($input);";

//%typemap_traits_ptr(SWIG_TYPECHECK_VECTOR, VectorDouble)
//%traits_type_name(VectorDouble)
//%typemap("rtypecheck") VectorDouble, VectorDouble*, VectorDouble&
//    %{ is.numeric($arg) %}
//%typemap("rtype") VectorDouble "numeric"
//%typemap("scoercein") VectorDouble, VectorDouble*, VectorDouble& "$input = as.numeric($input);";

//%typemap("rtypecheck") VectorString, VectorString*, VectorString&
//   %{ is.character($arg) %}
//%typemap("rtype") VectorString, VectorString*, VectorString& "character"
//%typemap("scoercein") VectorString, VectorString*, VectorString& "$input = as.character($input);";

//%typemap(in) VectorInt,
//             VectorDouble, 
//             VectorString//
//{
//  auto myvec = $1.getVectorPtr();
//  int res = swig::asptr($input, &myvec); // This do not affect $1
//  // So we copy the vector
//  // TODO : reserve
//  for (const auto& i: *myvec)
//  {
//    std::cout << "push_back:" << i << std::endl;
//    $1.push_back(i);
//  }
//}

// References are considered as pointer hence this typemap presence (a local variable is then used)
%typemap(in, fragment="ToVectorT") const VectorInt&    (VectorInt container),
                                   const VectorDouble& (VectorDouble container),
                                   const VectorString& (VectorString container)
{ 
  const int errcode = fillContainer($input, container);
  if (!SWIG_IsOK(errcode))
    %argument_fail(errcode, "$type", $symname, $argnum);
  $1 = &container;
}

////////////////////////////
// C++ => R

%typemap(scoerceout) VectorInt,    VectorInt*,    VectorInt&,
                     VectorDouble, VectorDouble*, VectorDouble&,
                     VectorString, VectorString*, VectorString&
 %{    %}

%typemap(out) VectorInt, 
              VectorDouble, 
              VectorString
{
  $result = swig::from(result.getVector());
}

%typemap(out) VectorInt*,    VectorInt&,
              VectorDouble*, VectorDouble&,
              VectorString*, VectorString&
{
  $result = swig::from(result->getVector());
}


// Put this after typemaps definition !
%include ../swig/swig_exp.i

///////////////////////////////////////////////////////////
//     Add target language additional features below     //
///////////////////////////////////////////////////////////

// TODO : Redirection of std::cout for windows RGui.exe users
