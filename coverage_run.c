#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>

#include "coverage.h"

int listener_main(int fd) {
   // read CFG
   unsigned char tmp;
   int lbl;
   unsigned char input[MAX_LEN];
   while (1) {
      read(fd, input, 1);
      switch (input[0]) {
         case 'F':
            read(fd, &tmp, 1);
            read(fd, input, tmp);
            input[tmp] = '\0';
            fprintf(stderr, "got transition to %s\n", input);
            break;
         case 'B':
            read(fd, &lbl, sizeof(int));
            fprintf(stderr, "got transition to label %d\n", lbl);
            break;
         case '\0':
            return 0;
      }
   }
   return 0;
}

int main(int argc, char **argv) {
   int fd;
   char *tmp = FIFO;
   unlink(tmp);
   if (mkfifo(tmp, 0666) != 0) {
      perror(strerror(errno));
      fprintf(stderr, "mkfifo failed\n");
      return 1;
   }
   unsigned char ready = 0;
   if (argc < 2) {
      fprintf(stderr, "Usage: ./coverage_run <target program>\n");
      return 1;
   }
   if (fork()) { // parent
      return execvp(argv[1], argv+1);
   }
   else { // child
      if ((fd = open(tmp, O_RDONLY)) == -1) {
         perror(strerror(errno));
         fprintf(stderr, "child open failed\n");
         return 1;
      }
      return listener_main(fd);
   }
}
