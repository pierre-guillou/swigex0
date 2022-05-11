library(myfibo)

i = testInt(12)
cat(class(i), "\n")
if (i != 12)
{
  cat("Wrong int!", "\n")
}
vi = testVectorInt(c(23,33,43))
cat(class(vi), "\n")
if (vi[1] != 23 || vi[2] != 33 || vi[3] != 43)
{
  cat("Wrong VectorInt!", "\n")
}
s = testString("Str12")
cat(class(s), "\n")
if (s != "Str12")
{
  cat("Wrong String!", "\n")
}
vs = testVectorString(c("Str23","Str33","Str43"))
cat(class(vs), "\n")
if (vs[1] != "Str23" || vs[2] != "Str33" || vs[3] != "Str43")
{
  cat("Wrong VectorString!", "\n")
}
