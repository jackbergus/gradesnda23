import math

import numpy
from numpy.random import Generator, MT19937, SeedSequence

class Mersenne:
    def __init__(self,seed=1):
        self.g = numpy.random.default_rng(seed)

    def extract_double(self, m=0, M=1):
        return self.g.uniform(m, M)

    def extract_integer(self, m=0, M=10):
        return self.g.integers(m, high=M+1)
