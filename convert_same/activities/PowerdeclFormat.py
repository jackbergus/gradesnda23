from activities.Settings import Var, Activity, VarLowHigh
from activities.SimpleDeclare import SelectionCondition, CorrelationCondition, VarCondTrue, Declare
import math


def quote(x:str)->str:
    return '"' + x.replace('"', '\\"') + '"'


def powerdecl_format_value(val):
    if isinstance(val, float):
        n = val
        sign = ""
        if n < 0:
            sign = "-"
        n = math.fabs(n)
        intV = str(int(n // 1))
        flp = n % 1
        if flp > 0.0:
            power = int(math.fabs(math.ceil(math.log10(n % 1))))
            return sign + intV + "." + ("0" * int(math.fabs(math.ceil(math.log10(n % 1))))) + str(n * power)[:2]
        else:
            return sign + intV + ".0"
    elif isinstance(val, int):
        return str(val)
    else:
        return quote(val)


def powerdecl_VarCondTrue_basic(label, var)->str:
    return "%s . %s" % (quote(label), "var "+quote(var))


def powerdecl_format_VarCondTrue_basic(a:VarCondTrue)->str:
    return powerdecl_VarCondTrue_basic(a.label.name, a.var.name)


def powerdecl_format_var(label:str,v:Var)->str:
    if isinstance(v, VarLowHigh):
        return powerdecl_VarCondTrue_basic(label, v.name)+" >= " + powerdecl_format_value(v.low) + " && " + powerdecl_VarCondTrue_basic(label, v.name)+" <= " + powerdecl_format_value(v.high)
    return None


def powerdecl_format_VarCondTrue_for_declare(a: VarCondTrue, dataless) ->str:
    if dataless:
        return "true"
    elif isinstance(a, SelectionCondition):
        cond =  "%s %s %s" % (powerdecl_format_VarCondTrue_basic(a), a.op.name, powerdecl_format_value(a.val))
        restr = powerdecl_format_var(a.label.name, a.var)
        if restr is None:
            return cond
        else:
            return cond + " && " + restr
    elif isinstance(a, CorrelationCondition):
        return  "%s %s %s" % (powerdecl_format_VarCondTrue_basic(a), a.op.name, powerdecl_format_VarCondTrue_basic(a.rhs))
    else:
        return "true"


def powerdecl_format_Declare(d:Declare,dataless=False)->str:
    conLeftCorr = ""
    conRightCorr = ""
    where = ""
    if (not dataless) and (d.corr is not None):
        conLeftCorr = powerdecl_format_var(d.corr.label.name, d.corr.var)
        conRightCorr = powerdecl_format_var(d.corr.rhs.label.name, d.corr.rhs.var)
        if conLeftCorr is None:
            conLeftCorr = ""
        else:
            conLeftCorr = " && " + conLeftCorr
        if conRightCorr is None:
            conRightCorr = ""
        else:
            conRightCorr = " && " + conRightCorr
        where = " where " + powerdecl_format_VarCondTrue_for_declare(d.corr, dataless)
    sth = ""
    if len(d.ls)==1:
        sth = quote(d.ls[0].label.name)+" , "+powerdecl_format_VarCondTrue_for_declare(d.ls[0], dataless)
    else:
        sth = quote(d.ls[0].label.name) +" , " + powerdecl_format_VarCondTrue_for_declare(d.ls[0],
                                                                                          dataless) + conLeftCorr + ", "
        sth = sth + quote(d.ls[1].label.name) +" , " + powerdecl_format_VarCondTrue_for_declare(d.ls[1],
                                                                                                dataless) + conRightCorr
    return quote(d.name)+"("+sth+")"+where


def powerdecl_dump(l,dataless=False)->str:
    return "\n".join(list(map(lambda x: powerdecl_format_Declare(x,dataless=dataless), l)))

def powerdecl_sigma(dvc):
    return "\n".join(list(map(lambda x: x.name, dvc.values())))