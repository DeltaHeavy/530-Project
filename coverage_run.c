#include <unistd.h>

#include "coverage.h"

int main(int argc, char **argv) {
   // pipe int fd[2]
   // fork+exec listener
   // blocking read "ready"
   // close read end
   // coverage_init(write end)
   // exec program
}
