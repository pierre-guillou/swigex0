%module(directors="1") myfibo

// Include C++ library SWIG interface files (Keep order!)
%include ../swig/swig_inc.i


//////////////////////////////////////////////////////////////
//        Specific SWIG feature for R target language       //
//////////////////////////////////////////////////////////////

%{
  #include <iostream>
%}

%include std_vector.i
%template(VectorIntStd)    std::vector<int>;

////////////////////////////
// R => C++

%typemap_traits_ptr(SWIG_TYPECHECK_VECTOR, VectorInt);
%traits_type_name(VectorInt);
%typemap("rtypecheck") VectorInt, VectorInt*, VectorInt&
   %{ is.integer($arg) || is.numeric($arg) %}
%typemap("rtype") VectorInt "integer"
%typemap("scoercein") VectorInt, VectorInt*, VectorInt& "$input = as.integer($input);";

%typemap_traits_ptr(SWIG_TYPECHECK_VECTOR, VectorDouble)
%traits_type_name(VectorDouble)
%typemap("rtypecheck") VectorDouble, VectorDouble*, VectorDouble&
    %{ is.numeric($arg) %}
%typemap("rtype") VectorDouble "numeric"
%typemap("scoercein") VectorDouble, VectorDouble*, VectorDouble& "$input = as.numeric($input);";

%typemap("rtypecheck") VectorString, VectorString*, VectorString&
   %{ is.character($arg) %}
%typemap("rtype") VectorString, VectorString*, VectorString& "character"
%typemap("scoercein") VectorString, VectorString*, VectorString& "$input = as.character($input);";

%typemap(in) VectorInt,
             VectorDouble, 
             VectorString
{
  auto myvec = $1.getVectorPtr();
  int res = swig::asptr($input, &myvec); // This do not affect $1
  // So we copy the vector
  // TODO : reserve
  for (const auto& i: *myvec)
    $1.push_back(i);
}

%typemap(in) VectorInt&,
             VectorDouble&,
             VectorString&
{
  auto myvec = $1->getVectorPtr();
  int res = swig::asptr($input, &myvec); // This do not affect $1
  // So we copy the vector
  // TODO : reserve
  for (const auto& i: *myvec)
    $1->push_back(i);
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
  r_ans = swig::from(result.getVector());
}

%typemap(out) VectorInt*,    VectorInt&,
              VectorDouble*, VectorDouble&,
              VectorString*, VectorString&
{
  r_ans = swig::from(result->getVector());
}


// Put this after typemaps definition !
%include ../swig/swig_exp.i

///////////////////////////////////////////////////////////
//     Add target language additional features below     //
///////////////////////////////////////////////////////////

// TODO : Redirection of std::cout for windows RGui.exe users