import swigex as mf

#pa = mf.AParent() # AParent is a pure abstract class
#mf.showHello(pa)

co = mf.ChildOne()
mf.showHello(co)

# This class is also pure abstract (should override clone)
# But it works !!!
class ChildTwo(mf.AParent):
    def __init__(self):
        super(ChildTwo,self).__init__()
    
    def getHello(self):
        return "ChildTwo in Python - Hello"
    
    #def clone(self):
    #    return ChildTwo()

ct = ChildTwo()
mf.showHello(ct)

