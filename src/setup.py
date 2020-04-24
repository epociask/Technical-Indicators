from distutils.core import setup
from Cython.Build import cythonize
import setuptools
from setuptools import Extension

#cmdclass.update({'build_ext': build_ext})

setup(
#    cmdclass = cmdclass,
    name = "test package",
    ext_modules = [Extension('testindicators', ['testindicators.pyx'])]
)
