#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "coverage.h"

int WRITE_FD = 2;

static char BUF[MAX_LEN];

void __coverage_init() {
   int fd = open(FIFO, O_WRONLY);
   WRITE_FD = fd;
}

void __f_transition(const char * const func) {
   snprintf(BUF, MAX_LEN, "F %s", func);
   BUF[1] = (unsigned char)strnlen(func, MAX_LEN);
   BUF[MAX_LEN-1] = '\0';
   write(WRITE_FD, BUF, strnlen(BUF, MAX_LEN)); 
}

void __bb_transition(const int label) {
   BUF[0] = 'B';
   memcpy(BUF+1, &label, sizeof(int));
   write(WRITE_FD, BUF, sizeof(int)+1);
}

void __coverage_end() {
   unsigned char null = '\0';
   write(WRITE_FD, &null, 1);
   close(WRITE_FD);
}
