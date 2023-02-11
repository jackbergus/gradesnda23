import csv
import os
import sys
import time

import numpy as np

from activities.AlloyGenDeclFormat import alloy_gen_decl_format_dump, alloy_command, alloy_run
from activities.PowerdeclFormat import powerdecl_dump, powerdecl_sigma
from activities.minerfulFormat import minerful_dump, minerful_command, minerful_run
from antlr4 import *
from gen.scratchLexer import scratchLexer
from gen.scratchParser import scratchParser
from gen.scratch import scratch

def load_declare_dictionary(path):
    d:dict[str,dict[str, str]]=dict()
    with open(path, "r") as f:
        reader = csv.reader(f, delimiter=",")
        for i, line in enumerate(reader):
            if sum(1 for x in line if x=="--")>0:
                continue
            else:
                d[line[2]] = {"knobab": line[2], "minerful": line[0], "alloy": line[1]}
    return d

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

def benchmark(type,ls, acts, conf, minL=10, maxL=20, logS=10000):
    if not os.path.exists("data"):
        os.mkdir("data")
    experiment_name = os.path.join("data", conf["experiment_name"]+"_"+str(type)+"_"+str(minL)+"_"+str(maxL)+"_"+str(logS))
    minerful_wd = conf["minerful_wd"]
    minerful_script = conf["minerful_script"]
    alloy_wd = conf["alloy_wd"]
    alloy_script = conf["alloy_jar"]
    d = load_declare_dictionary("alignment.csv")
    benchmark_csv = "benchmarks.csv"
    file_exists = os.path.isfile(benchmark_csv)
    with open(benchmark_csv, 'a') as csvF:
        writer = csv.writer(csvF, delimiter=',')
        if not file_exists:
            writer.writerow(['ExperimentName', 'minL', 'maxL', 'logS', 'algorithm', 'time'])  # file doesn't exist yet, write a header
        with open(experiment_name+".decl2", "w") as text_file:
            text_file.write(alloy_gen_decl_format_dump(ls, acts, d))
        while not os.path.exists(experiment_name+".decl2"):
            time.sleep(1)
        alloy_run(alloy_script, minL, maxL, logS, experiment_name, alloy_wd, writer)
        with open(experiment_name+".powerdecl", "w") as text_file:
            text_file.write(powerdecl_dump(ls))
        with open(experiment_name+".powerdecl", "w") as text_file:
            text_file.write(powerdecl_dump(ls, True))
        with open(experiment_name+"_knobab_sigma.txt", "w") as text_file:
            text_file.write(powerdecl_sigma(acts))
        with open(experiment_name+".json", "w") as text_file:
            text_file.write(minerful_dump(ls, acts, d))
        while not os.path.exists(experiment_name+".json"):
            time.sleep(1)
        minerful_run(minerful_script, minL, maxL, logS, experiment_name, minerful_wd, writer)

if __name__ == '__main__':
    conf = {}
    conf["minerful_script"] = "run-MINERfulEventLogMaker.sh"
    conf["minerful_wd"] = "/home/giacomo/projects/loggen/competitors/minerful/"
    conf["alloy_jar"] = "AlloyLogGenerator.jar"
    conf["alloy_wd"] = "/home/giacomo/projects/loggen/competitors/AlloyLogGenerator/"
    conf["experiment_name"] = "test"
    conf["minpowL"] = 1
    conf["maxpowL"] = 5
    conf["baseL"] = 10
    conf["minpowS"] = 1
    conf["maxpowS"] = 4
    conf["baseS"] = 10
    env = ["", "~", "generator.txt", "1", "4"]
    type, ls, acts = generate_model(env)
    for logS in map(lambda x: int(x), np.logspace(conf["minpowL"], conf["maxpowL"], conf["baseL"], endpoint=True)):
        for traceS in map(lambda x: int(x), np.logspace(conf["minpowS"], conf["maxpowS"], conf["baseS"], endpoint=True)):
            print("log size="+str(logS)+", traceLength="+str(traceS))
            benchmark(type, ls, acts, conf, traceS, traceS, logS)