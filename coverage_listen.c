#include <unistd.h>

int main(int argc, char **argv) {
   // read in CFG
   // write "ready" to fd
   // close write end
   // read -> update -> loop
   // read EOF -> break
   // generate statistics, print, exit
}
