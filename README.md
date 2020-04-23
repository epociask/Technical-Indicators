# Indicator Functions using cython (v0.0.1)
@Author epociask

Still in infancy will require a good amount of work

Currently only provide support for SMA, Upper Fibonnaci Retracement Levels, && Bollinger Bands (Many to come and many to be ported over from original python)

### Not currently supported on windows, should work with most mac & linux distributions 

## To Install (For Now)

### Add to python envrionment (PIP) 
``` 
pip install -i https://test.pypi.org/simple/ cython-indicators==0.0.1
```

### Add to python envrionment (Manual)
``` 
git clone https://github.com/epociask/cython_indicator_functions.git 

python3 setup.py build 

python3 setup.py install --user 
```


## To Run (For Now)

```python

import indicators

closes = [12.3, 11.5, 23.5, 24.2, 32.4]

print(indicators.SMA(closes, 4))
```
>22.9
```

```
