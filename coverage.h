#ifndef _COVERAGE_H
#define _COVERAGE_H

#define FIFO "/tmp/cvg_fifo"
#define MAX_LEN 256

void __f_transition(const char * const func);
void __bb_transition(const int label);

#endif
