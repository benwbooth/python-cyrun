#!/usr/bin/env bash
':' ''''
exec python3 - "$0" "$@" <<'EOS'
import distutils.core, Cython.Build, importlib, os, os.path, sys, socket, multiprocessing, distutils.sysconfig, errno, shutil, tempfile, re, platform
sys.argv.pop(0)
build_dir = os.path.join(
    os.environ.get("CYTHON_BIN", ".cython" if os.path.exists(".cython") else os.path.expanduser("~/.cache/cython")),
    re.sub('/', '%2F', re.sub('%', '%%', "/".join([socket.gethostname(), platform.python_version(), os.path.abspath(sys.argv[0])]))))
module = os.path.splitext(os.path.basename(sys.argv[0]))[0]
try: os.makedirs(build_dir, 0o700)
except OSError as e: 
    if e.errno != errno.EEXIST: raise
tmpdir = tempfile.mkdtemp(dir=build_dir)
try:
    for f in os.listdir(build_dir): 
        if os.path.isfile(os.path.join(build_dir,f)):
            mtime = os.path.getmtime(os.path.join(build_dir, f))
            with open(os.path.join(tmpdir, f), "a"): 
                os.utime(os.path.join(tmpdir, f), (mtime, mtime))
    config = distutils.sysconfig.get_config_vars()
    config["CFLAGS"] = ""
    distutils.core.setup(ext_modules=Cython.Build.cythonize(distutils.core.Extension( 
                module, sources=[sys.argv[0]]), 
            build_dir=tmpdir, quiet="VERBOSE" not in os.environ, nthreads=multiprocessing.cpu_count()), 
        script_args=["-v" if "VERBOSE" in os.environ else "-q","build_ext","-b",tmpdir,"-t","/"])
    for f in os.listdir(tmpdir):
        if not os.path.exists(os.path.join(build_dir, f)) or (os.path.getmtime(os.path.join(build_dir, f)) < os.path.getmtime(os.path.join(tmpdir, f))):
            os.rename(os.path.join(tmpdir, f), os.path.join(build_dir, f))
finally: shutil.rmtree(tmpdir)
sys.path.insert(0, os.path.abspath(build_dir))
importlib.import_module(module)
EOS
'''
__doc__ = """"""

import sys
cdef int i=0
i += 1
print("Hello World!")
