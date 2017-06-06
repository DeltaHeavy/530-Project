#include <stdio.h>
#include <stdbool.h>

void uncalled(int c) {
   if (c) {
      printf("true?\n");
   }
   else {
      printf("false!\n");
   }
}

void called(int c) {
   if (c) {
      printf("bing\n");
   }
   else {
      printf("google\n");
   }
}

int main(int argc, char **argv) {
   called(0);
   return 0;
}
