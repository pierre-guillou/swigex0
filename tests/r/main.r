source(file.path(Sys.getenv("MYFIBO_SOURCE_DIR"),"r/rfibo_loader.R"))
load_myfibo(file.path(Sys.getenv("MYFIBO_SOURCE_DIR"),"build/r/Release/myfibo"))

vec = fib(40)
print(vec)
f1 = Fibo(50, "Test 50")
f1$display()
f2 = Fibo(100, "Test 100")
f2$display()

