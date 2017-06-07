INPUTS = $(foreach in,$(shell ls tests/),$(basename $(in)))

all: instr normal $(foreach in,$(INPUTS),pre_instr_ll/$(in).ll)
instr: coverage_run $(foreach in,$(INPUTS),out/$(in)) $(foreach in,$(INPUTS),instr_ll/$(in).ll)
normal: $(foreach in,$(INPUTS),normal_out/$(in))

normal_out/%: pre_instr_ll/%.ll
	clang -O2 $^ -o $@

pre_instr_ll/%.ll: tests/%.c
	clang -O0 -S -g -emit-llvm $^ -o $@

instr_ll/%.ll: pre_instr_ll/%.ll instr_ll.py
	python3 instr_ll.py $< $@ cfg/$*.cfg

out/%: instr_ll/%.ll coverage.c
	clang -fsanitize=address -O2 $^ -o $@

coverage_%: coverage_%.c
	clang -O2 $^ -o $@

.PHONY: clean
clean:
	$(RM) pre_instr_ll/*
	$(RM) instr_ll/*
	$(RM) cfg/*
	$(RM) normal_out/*
	$(RM) out/*
	$(RM) coverage_run

test:
	@clear
	@echo hello
	@echo ==================================================
	@./coverage_run ./out/hello ./cfg/hello.cfg
	@read a
	@clear
	@echo goto
	@echo ==================================================
	@./coverage_run ./out/goto ./cfg/goto.cfg
	@read a
	@clear
	@echo func_calls
	@echo ==================================================
	@./coverage_run ./out/func_calls ./cfg/func_calls.cfg
	@read a
	@clear
	@echo uncalled_funcs
	@echo ==================================================
	@./coverage_run ./out/uncalled_funcs ./cfg/uncalled_funcs.cfg
	@read a
	@clear
	@echo unreached_blocks
	@echo ==================================================
	@./coverage_run ./out/unreached_blocks ./cfg/unreached_blocks.cfg
	@read a
	@clear
	@echo linkedlist
	@echo ==================================================
	@./coverage_run ./out/linkedlist ./cfg/linkedlist.cfg
	@read a
	@clear
	@echo leakedlist
	@echo ==================================================
	@./coverage_run ./out/leakedlist ./cfg/leakedlist.cfg
	@read a
	@clear
