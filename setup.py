# all .pyx files in a folder
from distutils.core import setup
from Cython.Build import cythonize
import setuptools
from setuptools import Extension

setuptools.setup(
    name="epociask", # Replace with your own username
    version="0.0.1",
    author="Ethen Pociask",
    author_email="epociask@volatrade.com",
    description="Indicator functions using cython",
    long_description="TO BE ADDED",
    long_description_content_type="text/markdown",
    url="https://github.com/pypa/sampleproject",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
    ext_modules = [Extension("indicators", ["src/indicators.pyx"])],
)

