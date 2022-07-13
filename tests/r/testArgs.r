library(myfibo)

a = TypeClass()
i = a$testInt(12)
cat(class(i), "\n")
if (i != 12)
{
  cat("Wrong int!", "\n")
}
i = a$testIntRef(22)
cat(class(i), "\n")
if (i != 22)
{
  cat("Wrong int Reference!", "\n")
}
i = a$testIntPtr(32)
cat(class(i), "\n")
#if (i != 32) # i is an externalptr
#{
#  cat("Wrong int Pointer!", "\n")
#}
vi = a$testVectorInt(c(23,33,43))
cat(class(vi), "\n")
if (vi[1] != 23 || vi[2] != 33 || vi[3] != 43)
{
  cat("Wrong VectorInt!", "\n")
}
vi = a$testVectorIntRef(c(24,34,44))
cat(class(vi), "\n")
if (vi[1] != 24 || vi[2] != 34 || vi[3] != 44)
{
  cat("Wrong VectorInt Reference!", "\n")
}
vi = a$testVectorIntPtr(c(25,35,45))
cat(class(vi), "\n")
if (vi[1] != 25 || vi[2] != 35 || vi[3] != 45)
{
  cat("Wrong VectorInt Pointer!", "\n")
}
d = a$testDouble(12.1)
cat(class(d), "\n")
if (d != 12.1)
{
  cat("Wrong int!", "\n")
}
d = a$testDoubleRef(22.2)
cat(class(d), "\n")
if (d != 22.2)
{
  cat("Wrong int Reference!", "\n")
}
d = a$testDoublePtr(32.3)
cat(class(d), "\n")
#if (d != 32.3) # d is an externalptr
#{
#  cat("Wrong int Pointer!", "\n")
#}
vi = a$testVectorDouble(c(23.1,33.1,43.1))
cat(class(vi), "\n")
if (vi[1] != 23.1 || vi[2] != 33.1 || vi[3] != 43.1)
{
  cat("Wrong VectorDouble!", "\n")
}
vi = a$testVectorDoubleRef(c(24.2,34.2,44.2))
cat(class(vi), "\n")
if (vi[1] != 24.2 || vi[2] != 34.2 || vi[3] != 44.2)
{
  cat("Wrong VectorDouble Reference!", "\n")
}
vi = a$testVectorDoublePtr(c(25.3,35.3,45.3))
cat(class(vi), "\n")
if (vi[1] != 25.3 || vi[2] != 35.3 || vi[3] != 45.3)
{
  cat("Wrong VectorDouble Pointer!", "\n")
}
s = a$testString("Str12")
cat(class(s), "\n")
if (s != "Str12")
{
  cat("Wrong String!", "\n")
}
s = a$testStringRef("Str22")
cat(class(s), "\n")
if (s != "Str22")
{
  cat("Wrong String Reference!", "\n")
}
#s = a$testStringPtr("Str32")
#cat(class(s), "\n")
#if (s != "Str32")
#{
#  cat("Wrong String Pointer!", "\n")
#}
vs = a$testVectorString(c("Str23","Str33","Str43"))
cat(class(vs), "\n")
if (vs[1] != "Str23" || vs[2] != "Str33" || vs[3] != "Str43")
{
  cat("Wrong VectorString!", "\n")
}
vs = a$testVectorStringRef(c("Str24","Str34","Str44"))
cat(class(vs), "\n")
if (vs[1] != "Str24" || vs[2] != "Str34" || vs[3] != "Str44")
{
  cat("Wrong VectorString Reference!", "\n")
}
vs = a$testVectorStringPtr(c("Str25","Str35","Str45"))
cat(class(vs), "\n")
if (vs[1] != "Str25" || vs[2] != "Str35" || vs[3] != "Str45")
{
  cat("Wrong VectorString Pointer!", "\n")
}
