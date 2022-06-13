library(myfibo)

f1 = Fibo(50)
invisible(f1$display(FALSE))
f2 = FiboEx(100, "Test 100")
invisible(f2$display())
vec = fib(40)
print(vec)

#f3 = Fibo(40)
#class(f3) <- c("FiboEx2", attr(f3,"class"))
#getFullTitle.FiboEx2 <- function(obj)
#{
#  getFull = selectMethod("getFullTitle", signature="Fibo")
#  return paste0("FiboEx2 - ", getFull(obj)) 
#}
#f3.display()

#child = AParent()
#class(child) <- c("Child", "AParent")
#getHello.Child <- function(obj)
#{
#  return "From Child in R - Hello"
#}
#f2.showHello(child)
