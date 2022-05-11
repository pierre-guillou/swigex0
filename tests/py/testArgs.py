import myfibo

i = testInt(12)
print(class(i))
if (i != 12) :
  print("Wrong int!")
vi = testVectorInt({23,33,43})
print(class(vi))
if (vi[0] != 23 || vi[1] != 33 || vi[2] != 43) :
  print("Wrong VectorInt!")
s = testString("Str12")
print(class(s))
if (s != "Str12") :
  print("Wrong String!")
vs = testVectorString({"Str23","Str33","Str43"})
print(class(vs))
if (vs[0] != "Str25" or vs[1] != "Str33" or vs[2] != "Str43") :
  print("Wrong VectorString!")

