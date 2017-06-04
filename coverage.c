#include <unistd.h>
#include <stdio.h>
#include <string.h>

#include "coverage.h"

#define MAX_LEN 64

int WRITE_FD = 0;

static char BUF[MAX_LEN];

/*
void __transition(const char * const func, const char * const label) {
   
   snprintf(BUF, MAX_LEN, "%s:%s\n", func, label);
   BUF[MAX_LEN-1] = '\0';
   write(WRITE_FD, BUF, strnlen(BUF, MAX_LEN));
}
*/

void transition() {
   printf("transition detected\n");
}
