

#' Creating a Fibonacci list and directly displaying the list in R
#' @param Maximum list number
#' @return The Fibo object
createFibo <- function(n)
{
  if (!require(swigex, quietly=TRUE))
    stop("Package swigex is mandatory to use this function!")
  f = Fibo(n)
  invisible(f$display())
  f
}