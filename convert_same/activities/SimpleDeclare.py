from enum import Enum
from typing import TypeVar, Generic, Sequence

from activities.Settings import Var, Activity

T = TypeVar('T')
Op = Enum('Op', ['<','>','<=','>=','=','!='])


class VarCondTrue:
    label:Activity
    var:Var

    def __init__(self,label:Activity=None,var:Var=None):
        self.label = label
        self.var = var

    def collect_vars(self)->list[Var]:
        return [self.var]

    def getActivityName(self):
        return self.label.name


class SelectionCondition(Generic[T],VarCondTrue):
    op:Op

    def __init__(self,label:Activity,var:Var,op:str,val:T):
        super().__init__(label,var)
        self.val = val
        self.op = Op[op]


class CorrelationCondition(Generic[T],VarCondTrue):
    op:Op
    rhs:VarCondTrue

    def __init__(self,label:Activity,var:Var,op:str,rhs:VarCondTrue):
        super().__init__(label,var)
        self.op = Op[op]
        self.rhs = rhs

    def collect_vars(self)->list[Var]:
        return [self.var, self.rhs.var]

class Declare:
    ls:list[VarCondTrue]
    name:str
    corr:CorrelationCondition

    def __init__(self, name:str, x:Sequence[VarCondTrue], corr:CorrelationCondition=None):
        self.name = name
        self.ls = list(x)
        self.corr=corr