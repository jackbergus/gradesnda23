from collections.abc import Sequence
from typing import TypeVar, Generic

from utils.Mersenne import Mersenne

T = TypeVar('T')

class Var:
    name:str

    def __init__(self,name:str):
        self.name = name

    def getName(self)->str:
        return self.name

    def getValue(self, m:Mersenne):
        pass

class VarLowHigh(Generic[T],Var):
    low:T
    high:T
    type:str

    def __init__(self, type:str, name:str, low:T, high:T):
        super().__init__(name)
        self.low = low
        self.high = high
        self.type = type


class VarInteger(VarLowHigh[int]):
    def __init__(self, name:str, low:int, high:int):
        super().__init__("integer", name, low, high)
        self.range = list(range(self.low, self.high+1))

    def getValue(self, m: Mersenne):
        return self.range[m.extract_integer(0, len(self.range)-1)]


class VarFloating(VarLowHigh[float]):
    def __init__(self, name:str, low:int, high:int):
        super().__init__("floating", name, low, high)
        self.range = range(self.low, self.high+1, (self.high-self.low)/10.0)

    def getValue(self, m: Mersenne):
        return self.range[m.extract_integer(0, len(self.range)-1)]


class VarString(Var):
    values:list[str]

    def __init__(self, name:str, values:list[str]):
        super().__init__(name)
        self.values = values

    def getValue(self, m: Mersenne):
        return self.values[m.extract_integer(0, len(self.values)-1)]


class Activity:
    name:str
    ls:list[Var]

    def __init__(self, name:str):
        self.name = name
        self.ls = list()

    def addVar(self, x):
        self.ls.append(x)


