.PHONY: clean

all: normal instrd
normal: normal_linkedlist normal_leakedlist normal_hello
instrd: linkedlist leakedlist helloworld

normal_linkedlist: ll.ll
	clang -O2 ll.ll -o normal_linkedlist

ll.ll: ll.c
	clang -O0 -S -g -emit-llvm ll.c

instr_ll.ll: ll.ll parse_ll.py
	python3 parse_ll.py ll.ll > instr_ll.ll

linkedlist: instr_ll.ll coverage.c
	clang -fsanitize=address -O2 instr_ll.ll coverage.c -o linkedlist

normal_leakedlist: leaky.ll
	clang -O2 leaky.ll -o normal_leakedlist

leaky.ll: leaky_ll.c
	clang -O0 -S -g -emit-llvm leaky_ll.c -o leaky.ll

instr_leaky.ll: leaky.ll parse_ll.py
	python3 parse_ll.py leaky.ll > instr_leaky.ll

leakedlist: instr_leaky.ll coverage.c
	clang -fsanitize=address -O2 instr_leaky.ll coverage.c -o leakedlist

normal_hello: helloworld.ll
	clang -O2 helloworld.ll -o normal_hello

helloworld.ll: helloworld.c
	clang -O0 -S -g -emit-llvm helloworld.c

instr_hello.ll: helloworld.ll parse_ll.py
	python3 parse_ll.py helloworld.ll > instr_hello.ll

helloworld: instr_hello.ll coverage.c
	clang -fsanitize=address -O2 instr_hello.ll coverage.c -o helloworld

clean:
	rm *.ll
	rm linkedlist leakedlist helloworld
	rm normal_linkedlist normal_leakedlist normal_hello
