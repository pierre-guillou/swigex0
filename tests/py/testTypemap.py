import myfibo
import numpy as np

a = myfibo.TypeClass()
a.setInt(12)
i = a.getInt()
print(type(i))
if (i != 12) :
  print("Wrong int!")
print(i)
a.setDouble(5.67)
d = a.getDouble()
print(type(d))
if (d != 5.67) :
  print("Wrong double!")
print(d)
a.setString("Str12")
s = a.getString()
print(type(s))
if (s != "Str12") :
  print("Wrong String!")
print(s)
a.setVectorInt([23,33,43])
vi = a.getVectorInt()
print(type(vi))
if (vi[0] != 23 or vi[1] != 33 or vi[2] != 43) :
  print("Wrong VectorInt!")
print(vi)
a.setVectorDouble(np.array([5.67,6.78,7.89]))
vd = a.getVectorDouble()
print(type(vd))
if (vd[0] != 5.67 or vd[1] != 6.78 or vd[2] != 7.89) :
  print("Wrong VectorDouble!")
print(vd)
a.setVectorString(["Str23","Str33","Str43"])
vs = a.getVectorString()
print(type(vs))
if (vs[0] != b'Str23' or vs[1] != b'Str33' or vs[2] != b'Str43') :
  print("Wrong VectorString!")
print(vs)