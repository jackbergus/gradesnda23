import os
import time

from activities.Settings import Var, VarLowHigh, VarString, Activity
from activities.SimpleDeclare import VarCondTrue, SelectionCondition, CorrelationCondition, Declare


def alloy_gen_decl_format_var(v:Var)->str:
    if isinstance(v, VarLowHigh):
        return "%s: %s between %s and %s" % (v.name, v.type, str(v.low), str(v.high))
    elif isinstance(v, VarString):
        return "%s: %s" % (v.name, ", ".join(v.values))
    else:
        return ""


def alloy_gen_decl_format_activity(a:Activity)->str:
    if len(a.ls) == 0:
        return "activity "+a.name
    else:
        return "activity %s\nbind %s: %s" % (a.name, a.name, ", ".join(list(map(lambda x: x.name, a.ls))))


def alloy_gen_decl_format_VarCondTrue_for_declare(a:VarCondTrue)->str:
    if isinstance(a, SelectionCondition):
        return "%s.%s %s %s" % (a.label.name, a.var.name, a.op.name, str(a.val))
    elif isinstance(a, CorrelationCondition):
        raise Exception("Sorry, AlloyLogGenerator does not support correlations")
    else:
        return " "


def alloy_gen_decl_format_Declare(d:Declare, di=None)->str:
    name = d.name
    fields = ",".join(list(map(lambda x: x.label.name, d.ls)))
    conds = " |".join( list(map(lambda x: alloy_gen_decl_format_VarCondTrue_for_declare(x), d.ls)))
    if di is not None:
        if name not in di:
            return ""
        else:
            name = di[name]["alloy"]
    return "%s[%s] |%s |" % (name, fields, conds)


def alloy_gen_decl_format_dump(l, dvc=None, d=None)->str:
    d_var: dict[str,Var] = dict()
    d_act: dict[str,Activity] = dict()
    if not dvc is None:
        for x in dvc:
            d_act[x] = dvc[x]
    for x in l:
        if x.corr is not None:
            d_var[x.corr.var.name] = x.corr.var
            d_var[x.corr.rhs.var.name] = x.corr.rhs.var
        for cc in x.ls:
            d_act[cc.label.name] = cc.label
            for var in cc.label.ls:
                if var is not None:
                    d_var[var.name] = var
            if cc.var is not None:
                d_var[cc.var.name] = cc.var
            for var in cc.collect_vars():
                if var is not None:
                    d_var[var.name] = var
    str = ""
    for x in d_act:
        a = d_act[x]
        str = str + alloy_gen_decl_format_activity(a) +"\n"
    for x in d_var:
        v = d_var[x]
        str = str + alloy_gen_decl_format_var(v)+"\n"
    return str+"\n".join(list(map(lambda x: alloy_gen_decl_format_Declare(x, d), l)))

def alloy_command(jar_path, minL, maxL, logS, logName):
    return "java -jar %s %d %d %d %s.decl2 %s.out.xes -eld -shuffle 2" % (jar_path, minL, maxL, logS, logName, logName)

def alloy_run(jar_path, minL, maxL, logS, logName, wd, csv, model_size, timeout=None):
    cwd = os.getcwd()
    os.chdir(wd)
    cmd = ['java', '-jar', jar_path, str(minL), str(maxL), str(logS), os.path.join(cwd, logName+".decl2"), os.path.join(cwd, logName+".out.xes"), '-eld', '-shuffle', '2']
    # print(" ".join(cmd))
    timeStarted = time.time()
    from subprocess import Popen, PIPE
    import subprocess
    breakMe=False
    timeDelta = None
    try:
        ans = subprocess.check_output(cmd, input=b'\r\n', timeout=timeout)
        #output = subprocess.run(cmd, stdout=subprocess.PIPE, timeout=timeout).stdout.decode('utf-8')
        timeDelta = time.time() - timeStarted
        timeDelta = timeDelta * 1000.0  # time in milliseconds
        os.chdir(cwd)
        csv.writerow([logName, minL, maxL, logS, model_size, 'alloy', timeDelta])
    except subprocess.TimeoutExpired:
        print(f'Timeout for {cmd} ({timeout}s) expired')
        os.chdir(cwd)
        csv.writerow([logName, minL, maxL, logS, model_size, 'alloy', timeDelta])
        breakMe=True
    os.chdir(cwd)
    return breakMe
