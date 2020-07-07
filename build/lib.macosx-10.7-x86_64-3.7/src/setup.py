# from distutils.core import setup
# from Cython.Build import cythonize
# from setuptools import Extension, setup
# import os
#
# requirementPath = '../requirements.txt'
# install_requires = []
#
# if os.path.isfile(requirementPath):
#     with open(requirementPath) as f:
#         install_requires = f.read().splitlines()
# setup(
#     name = "test package",
#     #install_requires=install_requires,
#     ext_modules = [Extension('testindicators', ['testindicators.pyx'])]
# )
