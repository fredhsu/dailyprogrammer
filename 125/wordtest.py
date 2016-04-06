import unittest

class wordTest(unittest.TestCase):
    def testRead(self):
        result = word.read("one.txt")
        self.assertEqual("one", result)
