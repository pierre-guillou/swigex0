import myfibo

i = myfibo.testInt(12)
print(type(i))
if (i != 12) :
  print("Wrong int!")
vi = myfibo.testVectorInt([23,33,43])
print(type(vi))
if (vi[0] != 23 or vi[1] != 33 or vi[2] != 43) :
  print("Wrong VectorInt!")
s = myfibo.testString("Str12")
print(type(s))
if (s != "Str12") :
  print("Wrong String!")
vs = myfibo.testVectorString(["Str23","Str33","Str43"])
print(type(vs))
if (vs[0] != "Str23" or vs[1] != "Str33" or vs[2] != "Str43") :
  print("Wrong VectorString!")

