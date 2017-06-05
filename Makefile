.PHONY: clean

all: ll.ll out.ll linkedlist

normal_linkedlist: ll.c
	clang -O0 -S -g -emit-llvm ll.c -o normal_ll.ll
	clang -O2 normal_ll.ll -o normal_linkedlist

ll.ll: ll.c
	clang -O0 -S -g -emit-llvm ll.c

out.ll: ll.ll parse_ll.py
	python3 parse_ll.py ll.ll > out.ll

linkedlist: out.ll
	clang -fsanitize=address -O2 out.ll coverage.c -o linkedlist

clean:
	rm out.ll ll.ll
