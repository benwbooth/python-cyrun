cyrun
=====

cyrun allows you to write cython code that runs like a scripting language,
with compilation happening in the background. Here is an example::

    #!/usr/bin/env cyrun
    print("Hello World!")

You can use the usual cython build metadata at the beginning of the
script to adjust compilation settings::

    # distutils: name = test
    # distutils: sources = 
    # distutils: define_macros = TESTMACRO
    # distutils: undef_macros = TESTMACRO
    # distutils: libraries = 
    # distutils: library_dirs = test
    # distutils: runtime_library_dirs = test
    # distutils: include_dirs = test
    # distutils: extra_objects = 
    # distutils: extra_compile_args = -Wall
    # distutils: extra_link_args = 
    # distutils: export_symbols = 
    # distutils: depends = 
    # distutils: language = c++

cyrun also adds the following metadata for searching for project-level module folders::

    # cyrun: base = modules # starting from script folder, search all
      top-level directories for a folder called modules, and add it to
      the include path and build path
    # cyrun: realpath = # if the script is a symlink, resolve it to the
      real path before searching
    # cyrun: ignore = # ignore certain folder names during the search
    # cyrun: interpolate = True # enable string interpolation for metadata strings

If the interpolate options is set, cython will enable string interpolation
using the `interpolate module <https://pypi.python.org/pypi/interpolate>`
on all the distutils metadata fields. This allows setting fields such
as include_dir dynamically, e.g.::

    # cyrun: interpolate = True
    # distutils: include_dirs = "{__import__('mymodule').__path__[0]}"

The interpolate module uses curly braces for templating, the same as
string.format(), except you are allowed to embed a python expression
instead of just variable names. Please note that only expressions are
allowed, not statements. Also, you'll have to avoid using double quotes
and curly braces within the templates, as escaping doesn't work well. Use
single quotes for strings and dict() for dictionaries if you need
them. See `interpolate docs <details on the syntax.>` and `interpolate
PyPI page <https://pypi.python.org/pypi/interpolate>` for more details.

cyrun stores compiled cython libraries in a cache folder::

    - if CYTHON_BIN environment variable is set, use that folder
    - otherwise, if there is a .cython folder in the script folder, use that
    - otherwise, set it to ~/.cache/cython

cyrun uses the following environment variables::

    CYTHON_BIN - optional path to cached cython binaries
    SKIP - if set, skip compilation step
    CHECK - if set, don't run the module after the build step
    VERBOSE - if set, enable verbose build output
    FORCE - if set, force compilation
    DEBUG - if set, run cygdb debugger on the compiled script

Compilation is performed using distutils and cythonize(). Modules will
only recompile if source code timestamps are newer than the cached
binary file.
