import os
import sys
from setuptools import setup, find_packages
from setuptools.extension import Extension
from setuptools.command.install import install
from Cython.Build import cythonize


VERSION = '0.0.1'

extensions = [
    Extension(
        "indicators",
        ["src/indicators.pyx"],
    )
]


def readme():
    with open('README.md') as f:
        return f.read()


class VerifyVersionCommand(install):
    """Custom command to verify that the git tag matches our version"""
    description = 'verify that the git tag matches our version'

    def run(self):
        tag = os.getenv('CIRCLE_TAG')

        if tag != VERSION:
            info = f'Git tag: {tag} does not match the version of this app: {VERSION}'
            sys.exit(info)


setup(
    setup_requires=[
            'setuptools>=18.0',
            'cython',
    ],
    name="cython_indicators",
    version=VERSION,
    author="Ethen Pociask",
    author_email="epociask@volatrade.com",
    description="Indicator functions using cython",
    long_description=readme(),
    long_description_content_type="text/markdown",
    url="https://github.com/VolaTrade/Technical-Indicators",
    install_requires=[
        'Cython==0.29.17',
        'numpy'
    ],
    packages=find_packages(),
    include_package_data=True,
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Intended Audience :: Developers",
        "Topic :: Software Development :: Technical Analysis",
        "Topic :: Software Development :: Libraries :: Python Modules",
        "Topic :: Internet",

    ],
    python_requires='>=3.6',
    cmdclass={
      'verify': VerifyVersionCommand,
    },
    ext_modules=cythonize(extensions)
)

