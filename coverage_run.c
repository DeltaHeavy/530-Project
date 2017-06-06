#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>

#include "coverage.h"

struct edge {
   int exec;
   int src;
   int dest;
};

struct func {
   int exec;
   char *name;
   unsigned char num_edges;
   struct edge* edges;
};

int LISTEN_READY = 0;

int listener_main(char *cfgpath) {
   unsigned char tmp;
   int cont = 1, i, j, fd, lbl, src, dest, cur_func, cur_block = 0;
   unsigned char *input, *cfg_orig, *cfg, num_funcs, name_len, num_edges;
   float fcvg = 0.0f, cvg = 0.0f;
   struct stat buf;
   struct func *funcs;

   int cfgfd = open(cfgpath, O_RDONLY);
   if (cfgfd == -1) {
      return 1;
   }
   fstat(cfgfd, &buf);
   cfg = (unsigned char *)calloc(buf.st_size, 1);
   read(cfgfd, cfg, buf.st_size);
   close(cfgfd);

   cfg_orig = cfg;
   num_funcs = cfg[0];
   cfg++;
   funcs = (struct func*)calloc(num_funcs, sizeof(struct func));
   for (i = 0; i < num_funcs; i++) {
      name_len = cfg[0];
      cfg++;
      funcs[i].name = (char *)calloc(name_len+1, 1);
      memcpy(funcs[i].name, cfg, name_len);
      if (!strncmp(funcs[i].name, "main", MAX_LEN)) {
         cur_func = i;
      }
      cfg += name_len+1;
      num_edges = cfg[0];
      ++cfg;
      funcs[i].num_edges = num_edges;
      funcs[i].edges = (struct edge*)calloc(num_edges, sizeof(struct edge));
      for (j = 0; j < num_edges; j++) {
         funcs[i].edges[j].src = ((int *)cfg)[0];
         funcs[i].edges[j].dest = ((int *)cfg)[1];
         cfg += 2*sizeof(int);
      }
   }
   LISTEN_READY = 1;
   if ((fd = open(FIFO, O_RDONLY)) == -1) {
      perror(strerror(errno));
      fprintf(stderr, "child open failed\n");
      return 1;
   }
   while (cont) {
      read(fd, &tmp, 1);
      switch (tmp) {
         case 'F':
            read(fd, &tmp, 1);
            input = (unsigned char *)calloc(tmp+1, 1);
            read(fd, input, tmp);
            input[tmp] = '\0';
            for (i = 0; i < num_funcs; i++) {
               if (!funcs[i].exec &&
                     !strncmp((char *)input, funcs[i].name, MAX_LEN)) {
                  funcs[i].exec = 1;
                  cur_func = i;
               }
            }
            free(input);
            break;
         case 'B':
            read(fd, &lbl, sizeof(int));
            for (j = 0; j < funcs[cur_func].num_edges; j++) {
               if (!funcs[cur_func].edges[j].exec &&
                     funcs[cur_func].edges[j].src == cur_block &&
                     funcs[cur_func].edges[j].dest == lbl) {
                  funcs[cur_func].edges[j].exec = 1; 
                  cur_block = lbl;
               }
            }
            break;
         case '\0':
            cont = 0;
            break;
         default:
            break;
      }
   }
   fprintf(stderr, "==================== COVERAGE ====================\n");
   for (i = 0; i < num_funcs; i++) {
      if (!funcs[i].exec) {
         fprintf(stderr, "%12s %12s : NOT COVERED\n", " ", funcs[i].name);
      }
      else {
         fprintf(stderr, "%12s %12s : COVERED\n", " ", funcs[i].name);
         fcvg += 1.0f;
         cvg = 0.0f;
         for (j = funcs[i].num_edges-1; j >= 0; j--) {
            if (funcs[i].edges[j].exec) {
               cvg += 1.0f;
            }
            else {
               fprintf(stderr, "%d->%d not taken\n", funcs[i].edges[j].src,
                                                     funcs[i].edges[j].dest);
            }
         }
         if (funcs[i].num_edges) {
            cvg /= funcs[i].num_edges;
            fprintf(stderr, "CFG Edge Coverage: %.2f\n", cvg*100.0f);
         }
      }
      free(funcs[i].name);
      free(funcs[i].edges);
   }
   fcvg /= num_funcs;
   fprintf(stderr, "Function Coverage: %.2f\n", fcvg*100.0f);
   free(funcs);
   free(cfg_orig);
   return 0;
}

int main(int argc, char **argv) {
   int status;
   pid_t listen, prog;
   unlink(FIFO);
   if (mkfifo(FIFO, 0666) != 0) {
      perror(strerror(errno));
      fprintf(stderr, "mkfifo failed\n");
      return 1;
   }
   unsigned char ready = 0;
   if (argc < 3) {
      fprintf(stderr, "Usage: ./coverage_run <target program> <target cfg>\n");
      return 1;
   }
   if ((listen = fork())) { // parent
      if ((prog = fork())) { // parent
         waitpid(prog, &status, WIFEXITED(NULL));
         waitpid(listen, &status, WIFEXITED(NULL));
         return 0;
      }
      else {
         while (LISTEN_READY) {
            fprintf(stderr, "waiting for listener...\n");
            sleep(1);
         }
         return execvp(argv[1], argv+1);
      }
   }
   else { // child
      return listener_main(argv[2]);
   }
}
