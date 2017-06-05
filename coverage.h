#ifndef _COVERAGE_H
#define _COVERAGE_H

void coverage_init(int fd);

void __f_transition(const char * const func);
void __bb_transition(const int label);

#endif
