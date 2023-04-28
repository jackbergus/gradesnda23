import csv
import os
import random
import string
import sys
import time
import yaml

from pathlib import Path
import numpy as np

from activities.AlloyGenDeclFormat import alloy_gen_decl_format_dump, alloy_command, alloy_run
from activities.PowerdeclFormat import powerdecl_dump, powerdecl_sigma, quote
from activities.minerfulFormat import minerful_dump, minerful_command, minerful_run
from antlr4 import *
from gen.scratchLexer import scratchLexer
from gen.scratchParser import scratchParser
from gen.scratch import scratch

def load_declare_dictionary(path):
    d:dict[str,dict[str, str]]=dict()
    nargs:dict[str,int]=dict()
    with open(path, "r") as f:
        reader = csv.reader(f, delimiter=",")
        for i, line in enumerate(reader):
            if i==0: continue
            if sum(1 for x in line if x=="--")>0:
                continue
            else:
                d[line[2]] = {"knobab": line[2], "minerful": line[0], "alloy": line[1]}
                nargs[line[2]] = int(line[3])
    return d,nargs

def generate_model_generator(all_model_name, size, globalvar_n, nargs, seed=4, m=1, M=101):
    with open(all_model_name,'w') as file:
        SIGMA = [x for x in string.ascii_uppercase]
        KAPPA = [x for x in string.ascii_lowercase]
        size = min(size, len(SIGMA))
        globalvar_n = min(globalvar_n, len(KAPPA))
        rng = random.Random(seed)
        SIGMA = SIGMA[:size]
        KAPPA = KAPPA[:globalvar_n]
        for k in KAPPA:
            x = rng.randint(m, M)
            y = rng.randint(m, M)
            if y<x:
                tmp=y
                y=x
                x=tmp
            file.write(('nglobal var %s [ %d : %d ]' % (quote(k),x,y)) + os.linesep)
        for A in SIGMA:
            z = rng.randint(0, len(KAPPA))
            if z > 0:
                rng.shuffle(KAPPA)
                file.write("event " + quote(A) +"{"+" ".join(["var %s" % quote(x) for x in KAPPA[:z]])+" }"+os.linesep)
        for k in nargs:
            file.write("template %s # %d" % (quote(k), nargs[k]) + os.linesep)



def generate_model(argv):
    input_stream = FileStream(argv[2])
    lexer = scratchLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = scratchParser(stream)
    vis = scratch()
    tree = None
    if argv[1] == "dump_spec":
        tree = parser.lang()
        vis.visit(tree)
        ls,acts= vis.finalise()
        return "dumpspec", ls, acts
    else:
        tree = parser.gen()
        vis.visit(tree)
        seed = 0
        nClauses = 1
        if len(argv)>=4:
            seed = int(argv[3])
            if len(argv)>=5:
                nClauses = int(argv[4])
        ls,acts = vis.generateSomeModel(seed, nClauses)
        return "gen", ls, acts

def benchmark(experiment_name, conf, i, minL=10, maxL=20, logS=10000, breakMinerful=False, breakAlloy=False):
    if not os.path.exists("data"):
        os.mkdir("data")
    minerful_wd = conf["minerful_wd"]
    minerful_script = conf["minerful_script"]
    alloy_wd = conf["alloy_wd"]
    alloy_script = conf["alloy_jar"]
    benchmark_csv = "alloy_benchmarks2.csv"
    file_exists = os.path.isfile(benchmark_csv)
    breakMinerful = False
    breakAlloy = False
    with open(benchmark_csv, 'a') as csvF:
        writer = csv.writer(csvF, delimiter=',')
        if not file_exists:
            writer.writerow(['ExperimentName', 'minL', 'maxL', 'logS', 'model_size', 'algorithm', 'time'])  # file doesn't exist yet, write a header
        timeout = None
        if "timeout" in conf["benchmark"]:
            timeout = conf["benchmark"]["timeout"]
        if conf["benchmark"]["minerful"] and not breakMinerful:
            breakMinerful = minerful_run(minerful_script, minL, maxL, logS, experiment_name, minerful_wd, writer, i, timeout=timeout)
        if conf["benchmark"]["alloy"] and not breakAlloy:
            breakAlloy = alloy_run(alloy_script, minL, maxL, logS, experiment_name, alloy_wd, writer, i, timeout=timeout)
    return breakMinerful, breakAlloy


def data_dump_model_gen(acts, ls, conf, type, i):
    experiment_name = os.path.join("data", conf["experiment_name"] + "_" + str(type) + "_" + str(i))
    d, _ = load_declare_dictionary("alignment.csv")
    if conf["model_size"]["generate"]:
        with open(experiment_name + ".decl2", "w") as text_file:
            text_file.write(alloy_gen_decl_format_dump(ls, acts, d))
        while not os.path.exists(experiment_name + ".decl2"):
            time.sleep(1)
        with open(experiment_name + ".powerdecl", "w") as text_file:
            text_file.write(powerdecl_dump(ls))
        with open(experiment_name + "_dataless.powerdecl", "w") as text_file:
            text_file.write(powerdecl_dump(ls, True))
        with open(experiment_name + "_knobab_sigma.txt", "w") as text_file:
            text_file.write(powerdecl_sigma(acts))
        with open(experiment_name + ".json", "w") as text_file:
            text_file.write(minerful_dump(ls, acts, d))
        while not os.path.exists(experiment_name + ".json"):
            time.sleep(1)
    return experiment_name



if __name__ == '__main__':
    conf = yaml.safe_load(Path('data.yaml').read_text())
    conf["minerful_script"] = conf["minerful"]["script"]
    conf["minerful_wd"] = conf["minerful"]["wd"]
    conf["alloy_jar"] = conf["alloy"]["jar"]
    conf["alloy_wd"] = conf["alloy"]["wd"]
    conf["minpowL"] = conf["log_size"]["minpow"]
    conf["maxpowL"] = conf["log_size"]["maxpow"]
    conf["baseL"] = conf["log_size"]["base"]
    conf["minpowS"] = conf["trace_size"]["minpow"]
    conf["maxpowS"] = conf["trace_size"]["maxpow"]
    conf["baseS"] = conf["trace_size"]["base"]
    conf["modelMin"] = conf["model_size"]["min"]
    conf["modelMax"] = conf["model_size"]["max"]
    conf["stepModel"] = conf["model_size"]["step"]
    print("Loading the allowed clauses:")
    d, nargs = load_declare_dictionary("alignment.csv")
    file = "test_model.txt"
    if conf["model_size"]["generate"]:
        print("Generating a full model generator file:")
        generate_model_generator(file, 20, 5, nargs)
        env = ["", "~", file, "1", str(int(len(nargs) * 2))]
        type, ls, acts = generate_model(env)
    else:
        print("Using the existing model")
        env = ["", "dump_spec", file, "1", str(int(len(nargs) * 2))]
        _, ls, acts = generate_model(env)
        type = "gen"
    for traceS in map(lambda x: conf["baseS"] ** x, range(conf["minpowS"], conf["maxpowS"]+1)):
        for logS in map(lambda x: conf["baseL"] ** x, range(conf["minpowL"], conf["maxpowL"]+1)):
            for i in range(conf["modelMin"], conf["modelMax"] + 1, conf["stepModel"]):
                currLS = ls[:i]
                experiment_name = data_dump_model_gen(acts, currLS, conf, type, i)
                print("Experiment: " + experiment_name)
                print("log size="+str(logS)+", traceLength="+str(traceS)+", modelSize="+str(i))
                breakMinerful = False
                breakAlloy = False
                for j in range(0, conf["benchmark"]["ntimes"]):
                    print("j="+str(j))
                    breakMinerful, breakAlloy = benchmark(experiment_name, conf, i, traceS, traceS, logS, breakMinerful=breakMinerful, breakAlloy=breakAlloy)
