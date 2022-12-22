# python setup.py build_ext --inplace

from distutils.core import setup
from Cython.Build import cythonize

setup(ext_modules=cythonize(["sumtest.pyx", "sumtest2.pyx"], language_level=3))
