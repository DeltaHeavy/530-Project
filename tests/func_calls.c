#include <stdio.h>

int bar() {
   printf("In bar\n");
   return 0;
}

void quux() {
   printf("In quux\n");
}

int baz() {
   quux();
   return bar();
}

int foo() {
   bar();
   return baz();
}

int main() {
   // foo, bar, baz, quux, bar
   return foo();
}
