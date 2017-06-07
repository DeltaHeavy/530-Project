#include <stdio.h>

int fib(int n, int p, int pp) {
   if (n < 2) {
      return p;
   }
   return fib(n-1, p+pp, p); 
}

int main() { 
   int x = 0, y;
   printf("%d: %d\n", 0, fib(0, 1, 1));
   printf("%d: %d\n", 1, fib(1, 1, 1));
   printf("%d: %d\n", 2, fib(2, 1, 1));
   printf("%d: %d\n", 3, fib(3, 1, 1));
   printf("%d: %d\n", 4, fib(4, 1, 1));
   printf("%d: %d\n", 5, fib(5, 1, 1));
   x = fib(14, 1, 1);
   while(--x) {
      y = fib(x, x+2, x-2);
      if (y < x && y > 0) {
         printf("%d\n", y);
      }
   }
   return 0;
}
