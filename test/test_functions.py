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
        a1, a2, a3 = testindicators.BOLINGER_BANDS(values, 4)
        self.assertEqual([float_format(a1), float_format(a2), float_format(a3)], [ 40.75, 85.21, -3.71])

    def testFIBONACCI(self): 
        expected = [51.728, 44.135999999999996, 31.863999999999997]
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
        self.assertEqual(expected, actual)