INPUTS = hello linkedlist leakedlist func_calls

all: instr normal $(foreach in,$(INPUTS),pre_instr_ll/$(in).ll)
instr: $(foreach in,$(INPUTS),out/$(in)) $(foreach in,$(INPUTS),instr_ll/$(in).ll)
normal: $(foreach in,$(INPUTS),normal_out/$(in))

normal_out/%: pre_instr_ll/%.ll
	clang -O2 $^ -o $@

pre_instr_ll/%.ll: tests/%.c
	clang -O0 -S -g -emit-llvm $^ -o $@

instr_ll/%.ll: pre_instr_ll/%.ll instr_ll.py
	python3 instr_ll.py $< $@ cfg/$*.cfg

out/%: instr_ll/%.ll coverage.c
	clang -fsanitize=address -O2 $^ -o $@

.PHONY: clean
clean:
	$(RM) pre_instr_ll/*
	$(RM) instr_ll/*
	$(RM) cfg/*
	$(RM) normal_out/*
	$(RM) out/*
