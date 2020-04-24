cp indicators.pyx testindicators.pyx
python3.6 setup.py build
python3.6 setup.py install --user
rm testindicators.pyx
