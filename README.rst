cyrun
=====

cyrun allows you to write cython code that runs like a scripting language,
with compilation happening in the background. Here is an example:

.. code-block:: python
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

If the setting begins with "interpolate:", then cython
will enable string interpolation using the `interpolate module
<https://pypi.python.org/pypi/interpolate>` on all the distutils metadata
fields. This allows setting fields such as include_dir dynamically, e.g.::

    # interpolate: distutils: include_dirs = {__import__('pysam').get_include()}
    # interpolate: distutils: extra_link_args = {__import__('pysam').get_libraries()}
    # interpolate: distutils: define_macros = {['%s=%s' % (d[0],d[1]) for d in __import__('pysam').get_defines()]}

The interpolate module uses curly braces for templating, the same as
string.format(), except you are allowed to embed a python expression
instead of just variable names. Please note that only expressions are
allowed, not statements. Also, you'll have to avoid using double quotes
and curly braces within the templates, as escaping doesn't work well. Use
single quotes for strings and dict() for dictionaries if you need
them. See `interpolate docs <http://edk141.co.uk/a/interpolate>` and `interpolate
PyPI page <https://pypi.python.org/pypi/interpolate>` for more details.

cyrun can take several command-line arguments before the script arguments.
cyrun can also read the CYRUN environment variable to pass in arguments as a
shell-escaped string. Here are the arguments cyrun accepts::

    -h, --help            show this help message and exit
    -v, --verbose         Show compiler output
    -s, --skip            Skip compilation step
    -c, --check           Just syntax check and compile, don't run the script
    -f, --force           Force compilation even if the compiled binary is up-
                            to-date
    -d, --debug           Run the script in the cython debugger
    -p PATH, --path PATH  Change the path for storing the cached cython binaries

cyrun stores compiled cython libraries in a cache folder::

    - if PATH argument is set in the CYRUN variable, use that folder
    - otherwise, if there is a .cyrun folder in the script folder, use that
    - otherwise, set it to ~/.cache/cyrun

Compilation is performed using distutils and cythonize(). Modules will
only recompile if source code timestamps are newer than the cached
binary file.
