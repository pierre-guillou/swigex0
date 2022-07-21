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
vvi = a$testVVectorInt(list(c(23,33,43),c(53,63),c(73,83,93)))
cat(class(vvi), "\n")
if (vvi[[1]][1] != 23 || vvi[[1]][2] != 33 || vvi[[1]][3] != 43 ||
    vvi[[2]][1] != 53 || vvi[[2]][2] != 63 ||
    vvi[[3]][1] != 73 || vvi[[3]][2] != 83 || vvi[[3]][3] != 93)
{
  cat("Wrong VectorVectorInt!", "\n")
}
vvi = a$testVVectorIntRef(list(c(24,34,44),c(54,64),c(74,84,94)))
cat(class(vvi), "\n")
if (vvi[[1]][1] != 24 || vvi[[1]][2] != 34 || vvi[[1]][3] != 44 ||
    vvi[[2]][1] != 54 || vvi[[2]][2] != 64 ||
    vvi[[3]][1] != 74 || vvi[[3]][2] != 84 || vvi[[3]][3] != 94)
{
  cat("Wrong VectorVectorInt Reference!", "\n")
}
vvi = a$testVVectorIntPtr(list(c(25,35,45),c(55,65),c(75,85,95)))
cat(class(vvi), "\n")
if (vvi[[1]][1] != 25 || vvi[[1]][2] != 35 || vvi[[1]][3] != 45 ||
    vvi[[2]][1] != 55 || vvi[[2]][2] != 65 ||
    vvi[[3]][1] != 75 || vvi[[3]][2] != 85 || vvi[[3]][3] != 95)
{
  cat("Wrong VectorVectorInt Pointer!", "\n")
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
vvd = a$testVVectorDouble(list(c(23.1,33.1,43.1),c(53.1,63.1),c(73.1,83.1,93.1)))
cat(class(vvd), "\n")
if (vvd[[1]][1] != 23.1 || vvd[[1]][2] != 33.1 || vvd[[1]][3] != 43.1 ||
    vvd[[2]][1] != 53.1 || vvd[[2]][2] != 63.1 ||
    vvd[[3]][1] != 73.1 || vvd[[3]][2] != 83.1 || vvd[[3]][3] != 93.1)
{
  cat("Wrong VectorVectorDouble!", "\n")
}
vvd = a$testVVectorDoubleRef(list(c(24.2,34.2,44.2),c(54.2,64.2),c(74.2,84.2,94.2)))
cat(class(vvd), "\n")
if (vvd[[1]][1] != 24.2 || vvd[[1]][2] != 34.2 || vvd[[1]][3] != 44.2 ||
    vvd[[2]][1] != 54.2 || vvd[[2]][2] != 64.2 ||
    vvd[[3]][1] != 74.2 || vvd[[3]][2] != 84.2 || vvd[[3]][3] != 94.2)
{
  cat("Wrong VectorVectorDouble Reference!", "\n")
}
vvd = a$testVVectorDoublePtr(list(c(25.3,35.3,45.3),c(55.3,65.3),c(75.3,85.3,95.3)))
cat(class(vvd), "\n")
if (vvd[[1]][1] != 25.3 || vvd[[1]][2] != 35.3 || vvd[[1]][3] != 45.3 ||
    vvd[[2]][1] != 55.3 || vvd[[2]][2] != 65.3 ||
    vvd[[3]][1] != 75.3 || vvd[[3]][2] != 85.3 || vvd[[3]][3] != 95.3)
{
  cat("Wrong VectorVectorDouble Pointer!", "\n")
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
#s = a$testStringPtr("Str32") # TODO : Crash with SEGV
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
# No VectorVectorString (doesn't exist in the C++ library)
v = a$testVectorInt(c()) # Empty vector
v = a$testVectorInt(101) # Single value
v = a$testVectorInt(c(102)) # Vector with 1 item
v = a$testVectorDouble(c()) # Empty vector
v = a$testVectorDouble(201.1) # Single value
v = a$testVectorDouble(c(202.1)) # Vector with 1 item
v = a$testVectorString(c()) # Empty vector
v = a$testVectorString("Str301") # Single value
v = a$testVectorString(c("Str302")) # Vector with 1 item
v = a$testVVectorInt(c()) # Empty vector
v = a$testVVectorInt(101) # Single value
v = a$testVVectorInt(c(102)) # Only 1 vector with 1 item
v = a$testVVectorInt(c(103, 104)) # Only 1 vector with 2 items
v = a$testVVectorDouble(c()) # Empty vector
v = a$testVVectorDouble(201.1) # Single value
v = a$testVVectorDouble(c(202.1)) # Only 1 vector with 1 item
v = a$testVVectorDouble(c(203.1, 204.1)) # Only 1 vector with 2 items
# No VectorVectorString (doesn't exist in the C++ library)