import json
from activities.SimpleDeclare import Declare
from opyenxes.factory.XFactory import XFactory
from opyenxes.data_out.XesXmlSerializer import XesXmlSerializer
import csv

def gen_minerful_template(name, ls):
    return {"template": name, "parameters": [[x] for x in ls]}


def minerful_format_Declare(d: Declare, di=None) -> dict:
    name = d.name
    if di is not None:
        if name not in di:
            return ""
        else:
            name = di[name]["minerful"]
    return gen_minerful_template(name, map(lambda x: x.getActivityName(), d.ls))


def minerful_dump(l, dvc=None, di=None) -> str:
    return json.dumps({"name": "bogus", "tasks": list(map(lambda x: x.name, dvc.values())),
                       "constraints": list(map(lambda x: minerful_format_Declare(x, di), l))}, indent=2)


def minerful_command(jar_path, minL, maxL, logS, logName):
    return "bash %s --input-model-file %s.json --input-model-encoding json  --size %d --minlen %d --maxlen %d " \
           "--out-log-encoding strings --out-log-file %s.json.txt" % (
               jar_path, logName, logS, minL, maxL, logName)

def minerful_run(jar_path, minL, maxL, logS, logName, wd, csv):
    import time, subprocess, os
    cwd = os.getcwd()
    os.chdir(wd)
    cmd = ['bash', jar_path, '--input-model-file', os.path.join(cwd, logName+".json"), '--input-model-encoding','json','--size',str(logS), '--minlen', str(minL), '--maxlen', str(maxL), '--out-log-encoding', 'strings', '--out-log-file', os.path.join(cwd, logName+".json.txt")]
    print(" ".join(cmd))
    timeStarted = time.time()
    output = subprocess.run(cmd, stdout=subprocess.PIPE).stdout.decode('utf-8')
    timeDelta = time.time() - timeStarted
    timeDelta = timeDelta * 1000.0 # time in milliseconds
    os.chdir(cwd)
    logScan = [x[1:-1].split(",") for x in output.splitlines()[2:]]
    log = XFactory.create_log()
    count = 0
    # Using for loop
    for t in logScan:
        trace = XFactory.create_trace()
        for activity_label in t:
            event = XFactory.create_event()
            attribute = XFactory.create_attribute_literal("concept:name", activity_label)
            event.get_attributes()["concept:name"] = attribute
            trace.append(event)
        log.append(trace)
    with open(logName+".json.txt.xes", "w") as f:
        XesXmlSerializer().serialize(log, f)
    csv.writerow([logName, minL, maxL, logS, 'minerful', timeDelta])


