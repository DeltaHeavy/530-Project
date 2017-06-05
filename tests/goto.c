#include <stdio.h>

int main() {
   goto here;
   printf("Hello?\n");
here:
   return 0;
}
