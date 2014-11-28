#!/usr/bin/env cyrun3
# #distutils: name = test
# #distutils: sources = 
# distutils: define_macros = TESTMACRO
# distutils: undef_macros = TESTMACRO
# #distutils: libraries = 
# distutils: library_dirs = test
# distutils: runtime_library_dirs = test
# distutils: include_dirs = test
# #distutils: extra_objects = 
# distutils: extra_compile_args = -Wall
# #distutils: extra_link_args = 
# #distutils: export_symbols = 
# #distutils: depends = 
# distutils: language = c++
import sys
cdef int i=0
i += 1
print("Hello World!")
