CSC 530 Project
===============

Max Zinkus for Dr. Clements' CSC 530 class, Grad Languages and Translators,
with a focus on fuzzing and testing.

This project is focused on evaluating C code coverage through simulated walks
of a CFG by instrumenting code to emit some sort of events as basic blocks are
traversed.

# Roadmap
* ANTLR :: C -> JSON
* Ingest JSON to AST
* Construct CFG from AST
* Learn LLVM layers
* EITHER add LLVM layer to instrument Basic Block transitions
* OR emit llvm assembly and "by hand" instrument transitions
* Catch transition events and map onto CFG
* Traverse CFG to determine coverage
