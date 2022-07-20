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
vvi = a.testVVectorInt([[23,33,43],[53,63],[73,83,93]])
print(type(vvi))
if (vvi[0][0] != 23 or vvi[0][1] != 33 or vvi[0][2] != 43 or
    vvi[1][0] != 53 or vvi[1][1] != 63 or
    vvi[2][0] != 73 or vvi[2][1] != 83 or vvi[2][2] != 93) :
  print("Wrong VectorVectorInt!")
vvi = a.testVVectorIntRef([[24,34,44],[54,64,74],[74,84,94]])
print(type(vvi))
if (vvi[0][0] != 24 or vvi[0][1] != 34 or vvi[0][2] != 44 or
    vvi[1][0] != 54 or vvi[1][1] != 64 or vvi[1][2] != 74 or
    vvi[2][0] != 74 or vvi[2][1] != 84 or vvi[2][2] != 94) :
  print("Wrong VectorVectorInt Reference!")
vvi = a.testVVectorIntPtr([[25,35,45],[55,65],[75,85,95]])
print(type(vvi))
if (vvi[0][0] != 25 or vvi[0][1] != 35 or vvi[0][2] != 45 or
    vvi[1][0] != 55 or vvi[1][1] != 65 or
    vvi[2][0] != 75 or vvi[2][1] != 85 or vvi[2][2] != 95) :
  print("Wrong VectorVectorInt Pointer!")
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
vd = a.testVectorDouble([23.1,33.1,43.1])
print(type(vd))
if (vd[0] != 23.1 or vd[1] != 33.1 or vd[2] != 43.1) :
  print("Wrong VectorDouble!")
vd = a.testVectorDoubleRef([24.2,34.2,44.2])
print(type(vd))
if (vd[0] != 24.2 or vd[1] != 34.2 or vd[2] != 44.2) :
  print("Wrong VectorDouble Reference!")
vd = a.testVectorDoublePtr([25.3,35.3,45.3])
print(type(vd))
if (vd[0] != 25.3 or vd[1] != 35.3 or vd[2] != 45.3) :
  print("Wrong VectorDouble Pointer!")
vvd = a.testVVectorDouble([[23.1,33.1,43.1],[53.1,63.1],[73.1,83.1,93.1]])
print(type(vvd))
if (vvd[0][0] != 23.1 or vvd[0][1] != 33.1 or vvd[0][2] != 43.1 or
    vvd[1][0] != 53.1 or vvd[1][1] != 63.1 or
    vvd[2][0] != 73.1 or vvd[2][1] != 83.1 or vvd[2][2] != 93.1) :
  print("Wrong VectorVectorDouble!")
vvd = a.testVVectorDoubleRef([[24.2,34.2,44.2],[54.2,64.2,74.2],[74.2,84.2,94.2]])
print(type(vvd))
if (vvd[0][0] != 24.2 or vvd[0][1] != 34.2 or vvd[0][2] != 44.2 or
    vvd[1][0] != 54.2 or vvd[1][1] != 64.2 or vvd[1][2] != 74.2 or
    vvd[2][0] != 74.2 or vvd[2][1] != 84.2 or vvd[2][2] != 94.2) :
  print("Wrong VectorVectorDouble Reference!")
vvd = a.testVVectorDoublePtr([[25.3,35.3,45.3],[55.3,65.3],[75.3,85.3,95.3]])
print(type(vvd))
if (vvd[0][0] != 25.3 or vvd[0][1] != 35.3 or vvd[0][2] != 45.3 or
    vvd[1][0] != 55.3 or vvd[1][1] != 65.3 or
    vvd[2][0] != 75.3 or vvd[2][1] != 85.3 or vvd[2][2] != 95.3) :
  print("Wrong VectorVectorDouble Pointer!")
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

a.testVectorInt(()) # Empty vector
a.testVectorInt(101) # Single value
a.testVectorInt((102)) # Vector with 1 item
a.testVectorDouble(()) # Empty vector
a.testVectorDouble(201.1) # Single value
a.testVectorDouble((202.1)) # Vector with 1 item
a.testVectorString(()) # Empty vector
a.testVectorString("Str301") # Single value
a.testVectorString(("Str302")) # Vector with 1 item
