library(swigex)

#pa = AParent() # AParent is a pure abstract class
#invisible(showHello(pa))

co = ChildOne()
invisible(showHello(co))

# TODO : Cannot inherits from AParent in R
#ct = AParent()
#class(ct) <- c("ChildTwo", "AParent")
#getHello.ChildTwo <- function(obj)
#{
#  return("ChildTwo - Hello")
#}
#
#showHello(ct)
