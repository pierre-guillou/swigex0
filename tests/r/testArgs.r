library(myfibo)

i = testInt(12)
cat(class(i), "\n")
if (i != 12)
{
  cat("Wrong int!", "\n")
}
i = testIntPtr(22)
cat(class(i), "\n")
if (i != 22)
{
  cat("Wrong int Pointer!", "\n")
}
#i = testIntCreate(32)
#cat(class(i), "\n")
#if (i != 32)
#{
#  cat("Wrong int Create!", "\n")
#}
vi = testVectorInt(c(23,33,43))
cat(class(vi), "\n")
if (vi[1] != 23 || vi[2] != 33 || vi[3] != 43)
{
  cat("Wrong VectorInt!", "\n")
}
#vi = testVectorIntPtr(c(24,34,44))
#cat(class(vi), "\n")
#if (vi[1] != 24 || vi[2] != 34 || vi[3] != 44)
#{
#  cat("Wrong VectorInt Pointer!", "\n")
#}
#vi = testVectorIntCreate(c(25,35,45))
#cat(class(vi), "\n")
#if (vi[1] != 25 || vi[2] != 35 || vi[3] != 45)
#{
#  cat("Wrong VectorInt Create!", "\n")
#}
s = testString("Str12")
cat(class(s), "\n")
if (s != "Str12")
{
  cat("Wrong String!", "\n")
}
#s = testStringPtr("Str22")
#cat(class(s), "\n")
#if (s != "Str22")
#{
#  cat("Wrong String Pointer!", "\n")
#}
#s = testStringCreate("Str32")
#cat(class(s), "\n")
#if (s != "Str32")
#{
#  cat("Wrong String Create!", "\n")
#}
vs = testVectorString(c("Str23","Str33","Str43"))
cat(class(vs), "\n")
if (vs[1] != "Str23" || vs[2] != "Str33" || vs[3] != "Str43")
{
  cat("Wrong VectorString!", "\n")
}
#vs = testVectorStringPtr(c("Str24","Str34","Str44"))
#cat(class(vs), "\n")
#if (vs[1] != "Str24" || vs[2] != "Str34" || vs[3] != "Str44")
#{
#  cat("Wrong VectorString Pointer!", "\n")
#}
vs = testVectorStringCreate(c("Str25","Str35","Str45"))
cat(class(vs), "\n")
if (vs[1] != "Str25" || vs[2] != "Str35" || vs[3] != "Str45")
{
  cat("Wrong VectorString Create!", "\n")
}
