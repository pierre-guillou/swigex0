import swigex as mf

ap = mf.AParent()
mf.showHello(ap)
co = mf.ChildOne()
mf.showHello(co)

# TODO : Cannot inherits from AParent in Python
#class ChildTwo(mf.AParent):
#    def __init__(self):
#        pass
#    
#    def getHello(self):
#        return "ChildTwo in Python - Hello"
#ct = ChildTwo()
#mf.showHello(ct)

