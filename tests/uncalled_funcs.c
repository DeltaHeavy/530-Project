#include <stdio.h>

float uncalled() {
   return 3.14f;
}

double called() {
   return 0.0;
}
   
int main() {
   printf("%.2f\n", called());
   return 0;
}
