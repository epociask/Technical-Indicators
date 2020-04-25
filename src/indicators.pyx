import numpy as np 
from libc.math cimport sqrt
cpdef float SMA(double[:] closes, int period):
        """
        Simple Moving Average function 
        @param closes: list of closing candle prices 
        @param period: period to calculate for 
        """        
        cdef int length = closes.shape[0]
        cdef float total = closes[length-period]
        cdef int i
        for i in xrange((length-period)+1, length):
                total += closes[i]
        return float(total/period)


cpdef float SDV(double[:] closes, int period):
        """
        Standard deviation function 
        @param closes: list of closing candle prices 
        @param period: period to calculate for 
        """
        cdef length = closes.shape[0]
        cdef float mean = SMA(closes, period)
        cdef float x_i = 0.0
        cdef int i 
        for i in xrange((length - period), length):
                x_i += (closes[i] - mean) ** 2        
        return float(sqrt(x_i/(period-1)))

#TODO add lower retracement 
cpdef FIB(double[:] closes, int period):
        """
        Fibonacci retracement equation; currently only support upper retracement
        @param closes: list of candle dictionaries in format {''} 
        @param period: period to calculate for 
        """
        cdef float low = 100000
        cdef float high = 0
        cdef float diff
        cdef int i  
        cdef int length = closes.shape[0]
        for i in xrange(length - period, length):
                if closes[i] < low:
                        low = closes[i]
                if closes[i] > high:
                        high = closes[i]

        diff = high - low
        return float(high - (0.236 * diff)), float(high - (0.382 * diff)), float(high - (0.618 * diff))



cpdef BOLINGER_BANDS(double[:] closes, int period):
        """
        Bolinger Band calculations function 
        @param closes: list of closing candle prices 
        @param period: period to calculate for 
        """
        cdef float sdv = SDV(closes, period)
        cdef float sma = SMA(closes, period)
        return (sma), (sma + sdv*2), (sma - sdv*2)


cpdef float MOMENTUM(double [:] closes, int period):
        """
        Momentum function 
        @param closes: list of closing candle prices 
        @param period: period to calculate for 
        """
        print(closes)
        print(period)
        cdef int length = closes.shape[0]
        return closes[length-1] - closes[length-period-1]        
        

cpdef float WMA(double[:] closes, int period, float weightedFactor):
        """
        Weighted moving average function 
        @param closes: list of closing candle prices 
        @param period: period to calculate for 
        """
        cdef int i 
        cdef length = closes.shape[0]
        cdef delta = period
        cdef ma = 0.0
        for i in xrange((length-period), length):
                ma += closes[i] * (delta/weightedFactor)
                delta -= 1

        return ma

#TODO implement
# cpdef float TMA(double[:] closes, int period):
#         """
#         Triangular moving average function 
#         @param closes: list of closing candle prices 
#         @param period: period to calculate for 
#         """
#         pass

#TODO implement 
# cpdef float AO(double[:] closes, int first_sma_period, int second_sma_period, int period):
        
#         assert period > second_sma_period and period >= first_sma_period : "invalid parameter combination"
#         cdef float low = 100000
#         cdef float high = 0
#         cdef float diff
#         cdef int i  
#         cdef int length = closes.shape[0]
#         cdef total_first, total_second = 0.0, 0.0
#         for i in xrange(length - period, length):
#              for j from i >= i - period by -1:

#         return first