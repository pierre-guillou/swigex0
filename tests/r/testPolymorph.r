library(swigex)

ap = AParent()
invisible(showHello(ap))
co = ChildOne()
invisible(showHello(co))

# TODO : Cannot inherits from AParent in R
#ct = AParent()
#class(ct) <- c("ChildTwo", "AParent")
#getHello.ChildTwo <- function(obj)
#{
#  return "ChildTwo - Hello"
#}
#showHello(ct)
