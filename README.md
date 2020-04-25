# Indicator Functions using cython (v0.0.1)
@Author epociask

Still in infancy will require a good amount of work

Currently only provide support for SMA, Upper Fibonnaci Retracement Levels, && Bollinger Bands (Many to come and many to be ported over from original python)

### Not currently supported on windows, should work with most mac & linux distributions 

## To Install (For Now)

### Add to python envrionment (PIP) 
```Bash
install cython-indicators  
```

### Add to python envrionment (Manual)
``` python
git clone https://github.com/epociask/cython_indicator_functions.git 

python setup.py build 

python setup.py install --user 
```


## To Run (For Now)

```python

import indicators
import numpy as np 

closes = np.array([12.3, 11.5, 23.5, 24.2, 32.4])

print(indicators.SMA(closes, 4))
```
>22.9
```

```
