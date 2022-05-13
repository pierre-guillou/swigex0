import myfibo

i = myfibo.testInt(12)
print(type(i))
if (i != 12) :
  print("Wrong int!")
#i = myfibo.testIntPtr(22)
#print(type(i))
#if (i != 22) :
#  print("Wrong int Pointer!")
#i = myfibo.testIntCreate(32)
#print(type(i))
#if (i != 32) :
#  print("Wrong int Create!")
vi = myfibo.testVectorInt([23,33,43])
print(type(vi))
if (vi[0] != 23 or vi[1] != 33 or vi[2] != 43) :
  print("Wrong VectorInt!")
#vi = myfibo.testVectorIntPtr([24,34,44])
#print(type(vi))
#if (vi[0] != 24 or vi[1] != 34 or vi[2] != 44) :
#  print("Wrong VectorInt Pointer!")
vi = myfibo.testVectorIntCreate([25,35,45])
print(type(vi))
if (vi[0] != 25 or vi[1] != 35 or vi[2] != 45) :
  print("Wrong VectorInt Create!")
s = myfibo.testString("Str12")
print(type(s))
if (s != "Str12") :
  print("Wrong String!")
#s = myfibo.testStringPtr("Str22")
#print(type(s))
#if (s != "Str22") :
#  print("Wrong String Pointer!")
#s = myfibo.testStringCreate("Str32")
#print(type(s))
#if (s != "Str32") :
#  print("Wrong String Create!")
vs = myfibo.testVectorString(["Str23","Str33","Str43"])
print(type(vs))
if (vs[0] != "Str23" or vs[1] != "Str33" or vs[2] != "Str43") :
  print("Wrong VectorString!")
#vs = myfibo.testVectorStringPtr(["Str24","Str34","Str44"])
#print(type(vs))
#if (vs[0] != "Str24" or vs[1] != "Str34" or vs[2] != "Str44") :
#  print("Wrong VectorString Pointer!")
vs = myfibo.testVectorStringCreate(["Str25","Str35","Str45"])
print(type(vs))
if (vs[0] != "Str25" or vs[1] != "Str35" or vs[2] != "Str45") :
  print("Wrong VectorString Create!")

