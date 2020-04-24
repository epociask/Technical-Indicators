cp indicators.pyx testindicators.pyx
python3.6 setup.py build
python3.6 setup.py install --user
rm test_package.egg-info -r 
rm build -r 
rm dist -r 
rm testindicators.pyx
rm testindicators.c 
