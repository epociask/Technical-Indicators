# Indicator Functions using cython (v0.0.6)
@Author epociask

** Still in infancy, gonna require a good amount of work ** 

## Currently provide support for:
* BB - [Bolinger Bands](https://www.investopedia.com/articles/technical/102201.asp)

* EMA -[Exponential Moving Average](https://www.investopedia.com/terms/e/ema.asp)

* FIB - [Upper Fibonacci Retracement Levels](https://www.investopedia.com/terms/f/fibonacciretracement.asp)

* FIB_BB - [Fibonacci Bolinger Bands](https://www.motivewave.com/studies/bollinger_bands_fib_ratios.htm)

* SMA - [Simple Moving Average](https://www.investopedia.com/terms/s/sma.asp)

* WMA - [Weighted Moving Average](https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/wma)

* SDV - [Standard Deviation](https://www.mathsisfun.com/data/standard-deviation-formulas.html)


## Adding Support For 

* FIB ARC - [Fibonacci Retracement Arc](https://www.investopedia.com/terms/f/fibonacciarc.asp)

## Currently Supported and Tested on

* MACOSX
* Kalinux_x86
* Debian_x86
* Fedora_x86
* Raspbian_x64

## To Install (For Now)

### Add to python envrionment (PIP) 
```Shell
pip install cython-indicators  
```

### Add to python envrionment (Manual)
``` Shell
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
