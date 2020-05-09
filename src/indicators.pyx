import numpy as np 
from libc.math cimport sqrt
from libc.stdlib cimport malloc, free
from cpython cimport array


cpdef float TRUERANGE(dict candle1, dict candle2):
        return abs(candle2['high'] - candle1['low'])


cpdef float ATR(list candles, int period):
        cdef int size = len(candles)
        cdef float sum_vals = 0.0 
        cdef int i 
        for i in xrange(size-period+1, size):
                sum_vals += TRUERANGE(candles[i-1], candles[i])

        return sum_vals/period


cpdef float SMOOTHED_ATR(list candles, int period):
        return ATR(candles, period-1) + (TRUERANGE(candles[2], candles[-1]) / period)

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
cpdef (float, float, float) FIB(double[:] closes, int period):
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



cpdef (float, float, float) BOLINGER_BANDS(double[:] closes, int period, int numberOfSDV):
        """
        Bolinger Band calculations function 
        @param closes: list of closing candle prices 
        @param period: period to calculate for 
        """
        cdef float sdv = SDV(closes, period)
        cdef float sma = SMA(closes, period)
        return (sma), (sma + sdv * numberOfSDV), (sma - sdv * numberOfSDV)


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


cpdef DERIVATIVE(double[:] values, int period): #TODO additional testing 
        """
        Derivate function... interpolates a list of values, derives the list, and returns d/dx list 
        @param values: to interpolate & derive
        @param period: period to calculate for
        """
        cdef int length = values.shape[0]
        cdef int j = 0
        cdef double[:] xvals = np.zeros((length-period,))
        cdef double[:] yvals = np.zeros((length-period,))
        for i in xrange(length - period, length):
                xvals[j] = j
                yvals[j] = SMA(values[0 : i], period)
                j+=1
        dx = np.diff(xvals)
        dy = np.diff(yvals)

        return (dy/dx)
        
cpdef list EMA(double[:] closes, int period, float alpha = .3, int epsilon = 0):
        """
        Exponential moving average function 
        @param closes: list of closing candle prices 
        @param period: period to calculate for 
        @param alpha: alpha value
        @param epsilon: epsilon value 
        """

        assert(0 < alpha < 1, ("out of range, alpha='%s'" % alpha))

        assert(not 0 <= epsilon < alpha, ("out of range, epsilon='%s'" % epsilon))

        assert(period>0, ("out of range, period='%s'" %period))

        cdef float currentWeight
        cdef float numerator      
        cdef float denominator 
        cdef int i 
        cdef int j 
        cdef int k = 0
        cdef int length = closes.shape[0]
        cdef double *results = <double *> malloc(sizeof(double)* (period+1))

        for i in xrange(length-period, length):
                currentWeight = 1.0
                numerator = 0.0 
                denominator = 0.0
                for j in xrange(i, 0, -1):
                        numerator += closes[j] * currentWeight
                        denominator += currentWeight

                        currentWeight *= alpha
                        if currentWeight < epsilon:
                                break
                results[k] = numerator / denominator
                k+=1
        try:
                return [e for e in results[:period]]

        finally:
                free(results)

# cpdef float EMA2(double[:] closes, int period):
#         cdef float multiplier
#         cdef int length = closes.shape[0]
#         multiplier = (2 /(period + 1))
#         ema = []
#         sma = SMA(closes, period)
#         cdef int j = 1 
#         ema.append(first_ema)
#         ema.append(( (s[period] - sma) * multiplier) + sma)

#         #now calculate the rest of the values
#         for i in s[period+1:]:
#                 tmp = ( (i - ema[j]) * multiplier) + ema[j]
#                 j = j + 1
#                 ema.append(tmp)

#         return ema


cpdef (float, float, float, float, float, float, float, float, float) FIB_BANDS(double[:] closes, int period):
        """
        Fibonacci Bolinger Bands function ... does retracements between ma/upper-band & ma/lower-band 
        @param closes: list of closing prices
        @param period: period to calculate for 
        """
        assert(period>0, ("out of range period='%s'" %period))
        cdef float ma 
        cdef float upper 
        cdef float lower 
        cdef float upperOn
        ma,  upper,  lower = BOLINGER_BANDS(closes, period, 2)
        cdef float diff = upper - lower 
        upperOne, upperTwo, upperThree = float(ma - (0.236 * diff)), float(ma - (0.382 * diff)), float(ma - (0.618 * diff))
        lowerOne, lowerTwo, lowerThree  = float(ma+  (0.236 * diff)), float(ma + (0.382 * diff)), float(ma + (0.618 * diff))
        return lower, lowerThree, lowerTwo, lowerOne, ma, upperOne , upperTwo, upperThree, upper 



cpdef (float, float) MACD(double[:] closes, int short_period, int long_period, int fast_period):
        """
        Moving Average Convergence Divergence............................................
        @param closes: list of closing prices
        @param period: period to calculate for
        @returns macd line, trend line tuple 
        """

        cdef list ema_short
        cdef list ema_long
        cdef list trend_line 
        macd_line = []
        assert((long_period > short_period > fast_period) , (f"Out of range period value provided {short_period}, {long_period}, {fast_period}"))
       
        ema_long = EMA(closes, long_period) 
        ema_short = EMA(closes, short_period)
        ema_long = ema_long[long_period-short_period : long_period]
        cdef int length = len(ema_short)
        cdef int i 
        print(ema_short)
        print(ema_long)
        for i in xrange(0, length):
                print(i)
                macd_line[i] = ema_short[i] - ema_long[i]
        trend_line = EMA(macd_line, fast_period)
        
        print(trend_line[-1])
        print(macd_line[-1])
        return macd_line[-1], trend_line[-1]

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