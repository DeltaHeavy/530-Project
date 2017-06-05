.PHONY: clean

all: normal instrd
normal: normal_out/normal_linkedlist normal_out/normal_leakedlist normal_out/normal_hello
instrd: out/linkedlist out/leakedlist out/hello

# linkedlist

normal_out/normal_linkedlist: %: pre_instr_ll/linkedlist.ll
	clang -O2 $^ -o $@

pre_instr_ll/linkedlist.ll: tests/linkedlist.c
	clang -O0 -S -g -emit-llvm tests/linkedlist.c -o pre_instr_ll/linkedlist.ll

instr_ll/instr_linkedlist.ll: pre_instr_ll/linkedlist.ll instr_ll.py
	python3 instr_ll.py pre_instr_ll/linkedlist.ll > instr_ll/instr_linkedlist.ll

out/linkedlist: instr_ll/instr_linkedlist.ll coverage.c
	clang -fsanitize=address -O2 instr_ll/instr_linkedlist.ll coverage.c -o out/linkedlist

# leakedlist

normal_out/normal_leakedlist: pre_instr_ll/leakedlist.ll
	clang -O2 $^ -o $@

pre_instr_ll/leakedlist.ll: tests/leakedlist.c
	clang -O0 -S -g -emit-llvm tests/leakedlist.c -o pre_instr_ll/leakedlist.ll

instr_ll/instr_leakedlist.ll: pre_instr_ll/leakedlist.ll instr_ll.py
	python3 instr_ll.py pre_instr_ll/leakedlist.ll > instr_ll/instr_leakedlist.ll

out/leakedlist: instr_ll/instr_leakedlist.ll coverage.c
	clang -fsanitize=address -O2 instr_ll/instr_leakedlist.ll coverage.c -o out/leakedlist

# hello

normal_out/normal_hello: pre_instr_ll/hello.ll
	clang -O2 $^ -o $@

pre_instr_ll/hello.ll: tests/hello.c
	clang -O0 -S -g -emit-llvm tests/hello.c -o pre_instr_ll/hello.ll

instr_ll/instr_hello.ll: pre_instr_ll/hello.ll instr_ll.py
	python3 instr_ll.py pre_instr_ll/hello.ll > instr_ll/instr_hello.ll

out/hello: instr_ll/instr_hello.ll coverage.c
	clang -fsanitize=address -O2 instr_ll/instr_hello.ll coverage.c -o out/hello

clean:
	rm pre_instr_ll/*
	rm instr_ll/*
	rm normal_out/*
	rm out/*
