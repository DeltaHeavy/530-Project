.PHONY: clean

all: ll.ll out.ll ll.out

ll.ll: ll.c
	clang -O0 -S -g -emit-llvm ll.c

out.ll: ll.ll parse_ll.py
	python3 parse_ll.py ll.ll > out.ll

ll.out: out.ll parse_ll.py
	clang -fsanitize=address -O2 out.ll coverage.c -o ll.out

clean:
	rm out.ll ll.ll
