# Example of libdir :
# /home/fors/Projets/test/swig/myfibo/build/r/Release/myfibo

load_myfibo = function(libdir)
{
  dyn.load(paste0(libdir,"/myfibo.so"))
  cacheMetaData(1)
  myfibo <- new.env()
  eval(parse(paste0(libdir,"/myfibo.R")), envir=myfibo)
  attach(myfibo)
}
