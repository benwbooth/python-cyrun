import setuptools, os
with open(os.path.join(os.path.dirname(__file__), 'README.rst')) as doc:
    __doc__=doc.read()

setuptools.setup(
    name='cyrun',
    version='0.26',
    description='compile and run cython in one line',
    url='https://github.com/benwbooth/python-cyrun',
    author='Ben Booth',
    author_email='benwbooth@gmail.com',
    license='MIT',
    keywords="cython python run executable",
    zip_safe=True,
    install_requires=['interpolate'],
    scripts=['cyrun'])
