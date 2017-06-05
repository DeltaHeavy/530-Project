.PHONY: clean

all: normal instrd
normal: normal_out/normal_linkedlist normal_out/normal_leakedlist normal_out/normal_hello
instrd: out/linkedlist out/leakedlist out/helloworld

normal_out/normal_linkedlist: pre_instr_ll/ll.ll
	clang -O2 pre_instr_ll/ll.ll -o normal_out/normal_linkedlist

pre_instr_ll/ll.ll: tests/ll.c
	clang -O0 -S -g -emit-llvm tests/ll.c -o pre_instr_ll/ll.ll

instr_ll/instr_ll.ll: pre_instr_ll/ll.ll instr_ll.py
	python3 instr_ll.py pre_instr_ll/ll.ll > instr_ll/instr_ll.ll

out/linkedlist: instr_ll/instr_ll.ll coverage.c
	clang -fsanitize=address -O2 instr_ll/instr_ll.ll coverage.c -o out/linkedlist

normal_out/normal_leakedlist: pre_instr_ll/leaky.ll
	clang -O2 pre_instr_ll/leaky.ll -o normal_out/normal_leakedlist

pre_instr_ll/leaky.ll: tests/leaky_ll.c
	clang -O0 -S -g -emit-llvm tests/leaky_ll.c -o pre_instr_ll/leaky.ll

instr_ll/instr_leaky.ll: pre_instr_ll/leaky.ll instr_ll.py
	python3 instr_ll.py pre_instr_ll/leaky.ll > instr_ll/instr_leaky.ll

out/leakedlist: instr_ll/instr_leaky.ll coverage.c
	clang -fsanitize=address -O2 instr_ll/instr_leaky.ll coverage.c -o out/leakedlist

normal_out/normal_hello: pre_instr_ll/helloworld.ll
	clang -O2 pre_instr_ll/helloworld.ll -o normal_out/normal_hello

pre_instr_ll/helloworld.ll: tests/helloworld.c
	clang -O0 -S -g -emit-llvm tests/helloworld.c -o pre_instr_ll/helloworld.ll

instr_ll/instr_hello.ll: pre_instr_ll/helloworld.ll instr_ll.py
	python3 instr_ll.py pre_instr_ll/helloworld.ll > instr_ll/instr_hello.ll

out/helloworld: instr_ll/instr_hello.ll coverage.c
	clang -fsanitize=address -O2 instr_ll/instr_hello.ll coverage.c -o out/helloworld

clean:
	rm pre_instr_ll/*
	rm instr_ll/*
	rm normal_out/*
	rm out/*
