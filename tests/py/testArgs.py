import myfibo

a = myfibo.TypeClass()
i = a.testInt(12)
print(type(i))
if (i != 12) :
  print("Wrong int!")
i = a.testIntRef(22)
print(type(i))
if (i != 22) :
  print("Wrong int Reference!")
#i = a.testIntPtr(32)
#print(type(i))
#if (i != 32) :
#  print("Wrong int Pointer!")
vi = a.testVectorInt([23,33,43])
print(type(vi))
if (vi[0] != 23 or vi[1] != 33 or vi[2] != 43) :
  print("Wrong VectorInt!")
vi = a.testVectorIntRef([24,34,44])
print(type(vi))
if (vi[0] != 24 or vi[1] != 34 or vi[2] != 44) :
  print("Wrong VectorInt Reference!")
vi = a.testVectorIntPtr([25,35,45])
print(type(vi))
if (vi[0] != 25 or vi[1] != 35 or vi[2] != 45) :
  print("Wrong VectorInt Pointer!")
d = a.testDouble(12.1)
print(type(d))
if (d != 12.1) :
  print("Wrong double!")
d = a.testDoubleRef(22.2)
print(type(d))
if (d != 22.2) :
  print("Wrong double Reference!")
#d = a.testDoublePtr(32.3)
#print(type(d))
#if (d != 32.3) :
#  print("Wrong double Pointer!")
vi = a.testVectorDouble([23.1,33.1,43.1])
print(type(vi))
if (vi[0] != 23.1 or vi[1] != 33.1 or vi[2] != 43.1) :
  print("Wrong VectorDouble!")
vi = a.testVectorDoubleRef([24.2,34.2,44.2])
print(type(vi))
if (vi[0] != 24.2 or vi[1] != 34.2 or vi[2] != 44.2) :
  print("Wrong VectorDouble Reference!")
vi = a.testVectorDoublePtr([25.3,35.3,45.3])
print(type(vi))
if (vi[0] != 25.3 or vi[1] != 35.3 or vi[2] != 45.3) :
  print("Wrong VectorDouble Pointer!")
s = a.testString("Str12")
print(type(s))
if (s != "Str12") :
  print("Wrong String!")
s = a.testStringRef("Str22")
print(type(s))
if (s != "Str22") :
  print("Wrong String Reference!")
#s = a.testStringPtr("Str32")
#print(type(s))
#if (s != "Str32") :
#  print("Wrong String Pointer!")
vs = a.testVectorString(["Str23","Str33","Str43"])
print(type(vs))
if (vs[0] != 'Str23' or vs[1] != 'Str33' or vs[2] != 'Str43') :
  print("Wrong VectorString!")
vs = a.testVectorStringRef(["Str24","Str34","Str44"])
print(type(vs))
if (vs[0] != 'Str24' or vs[1] != 'Str34' or vs[2] != 'Str44') :
  print("Wrong VectorString Reference!")
vs = a.testVectorStringPtr(["Str25","Str35","Str45"])
print(type(vs))
if (vs[0] != 'Str25' or vs[1] != 'Str35' or vs[2] != 'Str45') :
  print("Wrong VectorString Pointer!")

