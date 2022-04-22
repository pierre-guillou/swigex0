import myfibo
import sys
import os

vec = myfibo.fib(40)
with open("main.out", mode="w") as file_object:
    print(vec, file=file_object)

fd = os.open("main.out", os.O_RDWR|os.O_APPEND)
prevfd = os.dup(sys.stdout.fileno())
os.dup2(fd, sys.stdout.fileno())
prev = sys.stdout
sys.stdout = os.fdopen(prevfd, "w")

f1 = myfibo.Fibo(50, "Test 50")
f1.display()
f2 = myfibo.Fibo(100, "Test 100")
f2.display()

os.dup2(prevfd, prev.fileno())
sys.stdout = prev
