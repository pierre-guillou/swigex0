import myfibo

class Child(myfibo.AParent):
    def __init__(self):
        pass
    
    def getHello(self):
        return "From Child in python - Hello"

class FiboEx2(myfibo.Fibo):
    def __init__(self, n, title):
        super().__init__(n, title)

    def getFullTitle(self):
        return f"FiboEx2 - {super()._title}"

f1 = myfibo.Fibo(50)
f1.display(False)
f2 = myfibo.FiboEx(100, "Test 100")
f2.display()
#f3 = FiboEx2(50, "Test 50")
#f3.display()
vec = myfibo.fib(40)
print(vec)
child = Child()
#f2.showHello(child)
print(child.getHello())
