CSC 530 Project
===============

Max Zinkus for Dr. Clements' CSC 530 class, Grad Languages and Translators,
with a focus on fuzzing and testing.

This project is focused on evaluating C code coverage through simulated walks
of a CFG by instrumenting code to emit some sort of events as basic blocks are
traversed.

# Roadmap
* Learn LLVM layers
* EITHER add LLVM layer to instrument Basic Block transitions
* OR emit llvm assembly and "by hand" instrument transitions
* Catch transition events and map onto CFG
* Traverse CFG to determine coverage

# Current step (due Friday, May 19th)
Given LLVM IR, parse to and create per-function control flow graphs
linking labels, create links between functions based on calls, and
create an overall graph with an entry to main.
