#!/usr/bin/python3

""" 
Max Zinkus
CSC 530
Evaluating traditional code coverage metrics by
tracking code progress over a CFG
"""

def read_file(fname):
    with open(fname, 'r') as f:
        d = f.readlines()
    return [l.rstrip() for l in d]

def name_from_def(d):
    return d[d.index('@')+1:d.index('(')]

def next_close(lines, d):
    i = lines.index(d)
    consider = lines[i:]
    close = list(filter(lambda line: line.startswith("}"), consider))[0]
    return i + consider.index(close) + 1

def func_split(lines):
    defs = list(filter(lambda line: line.startswith("define"), lines))
    funcs = {}
    for d in defs:
        name = name_from_def(d)
        funcs[name] = lines[lines.index(d):next_close(lines, d)]
    return funcs 

if __name__ == '__main__':
    from sys import argv
    if len(argv) > 1:
        s = func_split(read_file(argv[1]))
        print('\n'.join(s['main']))
