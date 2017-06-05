#include <unistd.h>
#include <stdio.h>
#include <string.h>

#include "coverage.h"

#define MAX_LEN 64

static int WRITE_FD = 1;

static char BUF[MAX_LEN];

void __f_transition(const char * const func) {
   snprintf(BUF, MAX_LEN, "-> function %s\n", func);
   BUF[MAX_LEN-1] = '\0';
   write(WRITE_FD, BUF, strnlen(BUF, MAX_LEN)); 
}

void __bb_transition(const int label) {
   snprintf(BUF, MAX_LEN, "-> label %d\n", label);
   BUF[MAX_LEN-1] = '\0';
   write(WRITE_FD, BUF, strnlen(BUF, MAX_LEN));
}

