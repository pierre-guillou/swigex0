# Install static library (and build python module)
# cmake -Bbuild -H. -DCMAKE_INSTALL_PREFIX=/home/fors/myfibo_install
# cmake --build build --target install

project(myfibopy)      

cmake_minimum_required(VERSION 3.20) # At least for USE_SWIG_DEPENDENCIES

add_subdirectory(src)
add_subdirectory(python)
