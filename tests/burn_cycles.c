#include <stdio.h>
#include <time.h>
#include <stdint.h>

int64_t timespecDiff(struct timespec *timeA_p, struct timespec *timeB_p)
{
     return ((timeA_p->tv_sec * 1000000000) + timeA_p->tv_nsec) -
                   ((timeB_p->tv_sec * 1000000000) + timeB_p->tv_nsec);
}


int fib(int n, int p, int pp) {
   if (n < 2) {
      return p;
   }
   return fib(n-1, p+pp, p); 
}

int main() { 
   int x = 0, y;
   struct timespec start, end;
   clock_gettime(CLOCK_MONOTONIC, &start);
   printf("%d: %d\n", 0, fib(0, 1, 1));
   printf("%d: %d\n", 1, fib(1, 1, 1));
   printf("%d: %d\n", 2, fib(2, 1, 1));
   printf("%d: %d\n", 3, fib(3, 1, 1));
   printf("%d: %d\n", 4, fib(4, 1, 1));
   printf("%d: %d\n", 5, fib(5, 1, 1));
   x = fib(15, 1, 1);
   while(--x) {
      y = fib(x, x+2, x-2);
      if (y < x && y > 0) {
         printf("%d\n", y);
      }
   }
   clock_gettime(CLOCK_MONOTONIC, &end);
   printf("%f ms elapsed\n", timespecDiff(&end, &start) / 1000000.0);
   return 0;
}
