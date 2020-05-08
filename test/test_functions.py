import unittest
import testindicators 
import numpy as np
values = np.array([12.0, 14.0, 64.0, 32.0, 53.0])
values1 = np.array([1.,2.,3.,4.,5.])
float_format = lambda number: float("{:.2f}".format(number))

class TestFunctions(unittest.TestCase):

    def testSMA(self): 
        expected = 40.75
        actual = testindicators.SMA(values, 4)
        self.assertEqual(expected, actual)

    def testMOMENTUM(self):
        expected = 39
        actual = testindicators.MOMENTUM(values, 3)
        self.assertEqual(expected, actual)

    def testSDV(self): 
        expected = 22.23 
        actual = testindicators.SDV(values, 4)
        self.assertAlmostEquals(expected, float_format(actual))

    def testBB(self): 
        a1, a2, a3 = testindicators.BOLINGER_BANDS(values, 4, 2)
        self.assertEqual([float_format(a1), float_format(a2), float_format(a3)], [ 40.75, 85.21, -3.71])

    def testFIBONACCI(self): 
        expected = [51.72800064086914, 44.13600158691406, 31.86400032043457]
        print("values ", values)
        a1, a2, a3 = testindicators.FIB(values, values.shape[0])
        self.assertListEqual(expected, [a1, a2, a3])


    def testWMA(self):
        expected = 89.2
        actual = testindicators.WMA(np.array([90.0, 89.0, 88.0, 89.0]), 4, 10)
        self.assertEqual(expected, float_format(actual))


    def testDERIVATIVE(self):
        expected = 1
        actual = testindicators.DERIVATIVE(values1, 2)
        print(actual)
        self.assertEqual(expected, actual[0])

    def testEMA(self):
        vals = np.array([1.9, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0 ,8.0])
        expected = np.array([1.0, 1.769230842590332, 2.6546761989593506, 3.604093313217163, 4.583608150482178, 5.575806140899658, 6.5729594230651855, 7.571954250335693])
        actual = np.array(testindicators.EMA(vals, 7))
        print("actual", actual) 
        print("expected", expected  )
        self.assertEqual(expected[-1], actual[-1]) 