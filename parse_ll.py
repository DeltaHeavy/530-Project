#!/usr/bin/python3

""" 
Max Zinkus
CSC 530
Evaluating traditional code coverage metrics by
tracking code progress over a CFG

TODO
* instrument in a global string for each label and function
"""

#INSTR_CALL = "  call void @__transition__(i8*" # TODO
INSTR_CALL = "  call void @transition()"

INSTR_DECLARE = "\ndeclare void @transition()\n"

def read_file(fname):
    """ file : str -> [line : str] """
    with open(fname, 'r') as f:
        d = f.readlines()
    return [l.rstrip() for l in d]

def name_from_def(d):
    """ line : str -> function name : str """
    return d[d.index('@')+1:d.index('(')]

def next_close(lines, d):
    """ [line : str] -> line -> index of next '}' : int """
    i = lines.index(d)
    consider = lines[i:]
    close = list(filter(lambda line: line.startswith("}"), consider))[0]
    return i + consider.index(close) + 1

def func_split(lines):
    """ [line : str] -> {name : str :: [line : str]} """
    defs = list(filter(lambda line: line.startswith("define") and not '.' in line, lines))

    funcs = {}
    after = {}
    names = []
    for d in defs:
        name = name_from_def(d)
        if not names:
            pre = lines[:lines.index(d)]
        if defs.index(d)+1 < len(defs):
            after[name] = lines[next_close(lines, d):lines.index(defs[defs.index(d)+1])]
        else:
            after[name] = lines[next_close(lines, d):]
        names.append(name)
        funcs[name] = lines[lines.index(d):next_close(lines, d)]

    return names, pre, funcs, after

def instrument_function(lines):
    """ [line : str] -> [line : str] """
    appends = []
    lines.insert(1, INSTR_CALL)
    for i in range(len(lines)):
        if "; <label>" in lines[i]:
            j = i
            while "phi" in lines[j+1]:
                j += 1
            appends.append(j+1)
    while appends:
        i = appends.pop()
        lines.insert(i, INSTR_CALL)
    return lines

if __name__ == '__main__':
    from sys import argv
    if len(argv) > 1:
        lines = read_file(argv[1])
        names, pre, funcs, after = func_split(lines)
        print('\n'.join(pre))
        print(INSTR_DECLARE)
        for k in names:
            funcs[k] = instrument_function(funcs[k])
            print('\n'.join(funcs[k]))
            print('\n'.join(after[k]))
