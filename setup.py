from setuptools import setup

setup(name='cyrun',
      version='0.1',
      description='compile and run cython in one line',
      url='https://github.com/benwbooth/python-cyrun',
      author='Ben Booth',
      author_email='benwbooth@gmail.com',
      license='MIT',
      packages=['cyrun'],
      keywords="cython python run executable",
      zip_safe=True,
      scripts=['cyrun','cyrun2','cyrun3'])