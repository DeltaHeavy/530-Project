#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <string.h>
#include <time.h>

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
   int *cur_block;
   int cur_depth;
};

int listener_main(char *cfgpath) {
   unsigned char tmp;
   int status, cont = 1, i, j, k, fd, lbl, src, dest, cur_func;
   unsigned char *input, *cfg_orig, *cfg, num_funcs, name_len, num_edges;
   float fcvg = 0.0f, cvg = 0.0f;
   struct stat buf;
   struct func *funcs;

   int cfgfd = open(cfgpath, O_RDONLY);
   if (cfgfd == -1) {
      return 1;
   }
   status = fstat(cfgfd, &buf);
   if (status == -1) {
      return 1;
   }
   cfg = (unsigned char *)calloc(buf.st_size, 1);
   status = read(cfgfd, cfg, buf.st_size);
   if (status != buf.st_size) {
      return 1;
   }
   status = close(cfgfd);
   if (status == -1) {
      return 1;
   }

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
         funcs[i].exec = 1;
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
      funcs[i].cur_block = (int *)calloc(sizeof(int), 1);
      funcs[i].cur_depth = 1;
   }
   if ((fd = open(FIFO, O_RDONLY)) == -1) {
      return 1;
   }
   while (cont) {
      status = read(fd, &tmp, 1);
      if (status != 1) {
         return 1;
      }
      switch (tmp) {
         case 'F':
            status = read(fd, &tmp, 1);
            if (status != 1) {
               return 1;
            }
            input = (unsigned char *)calloc(tmp+1, 1);
            status = read(fd, input, tmp);
            if (status != tmp) {
               return 1;
            }
            input[tmp] = '\0';
            for (i = 0; i < num_funcs; i++) {
               if (!strncmp((char *)input, funcs[i].name, MAX_LEN)) {
                  funcs[i].exec = 1;
                  if (cur_func == i) { // recursive call
                     funcs[i].cur_block = realloc(funcs[i].cur_block,
                           ++funcs[i].cur_depth*sizeof(int));
                     memmove(funcs[i].cur_block+1, funcs[i].cur_block, funcs[i].cur_depth-1); 
                  }
                  cur_func = i;
                  *(funcs[cur_func].cur_block) = 0;
               }
            }
            free(input);
            break;
         case 'B':
            status = read(fd, &lbl, sizeof(int));
            if (status != sizeof(int)) {
               return 1;
            }
            status = 0;
            for (j = 0; j < funcs[cur_func].num_edges && !status; j++) {
               if (funcs[cur_func].edges[j].src == *(funcs[cur_func].cur_block) &&
                   funcs[cur_func].edges[j].dest == lbl) {
                  if (!funcs[cur_func].edges[j].exec) {
                     funcs[cur_func].edges[j].exec = 1; 
                  }
                  *(funcs[cur_func].cur_block) = lbl;
                  status = 1;
               }
            }
            for (i = 0; i < num_funcs && !status; i++) { // didn't find edge
               for (j = 0; j < funcs[i].num_edges && !status; j++) {
                  if (lbl == funcs[i].edges[j].dest ||
                      lbl == funcs[i].edges[j].src) {
                     if (cur_func == i) { // return from recursive call
                        funcs[i].cur_depth--;
                        memmove(funcs[i].cur_block, funcs[i].cur_block+1, funcs[i].cur_depth);
                     }
                     cur_func = i;
                     for (k = 0; k < funcs[cur_func].num_edges; k++) {
                        if (*(funcs[cur_func].cur_block) == funcs[cur_func].edges[k].src &&
                            lbl == funcs[cur_func].edges[k].dest) {
                           funcs[cur_func].edges[k].exec = 1;
                        }
                     }
                     *(funcs[cur_func].cur_block) = lbl;
                     status = 1;
                  }
               }
            }
            if (!status) {
               fprintf(stderr, "bad edge %d->%d\n", *(funcs[cur_func].cur_block), lbl);
               return 1;
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
         for (j = 0; j < funcs[i].num_edges; j++) {
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
      free(funcs[i].cur_block);
   }
   fcvg /= num_funcs;
   fprintf(stderr, "Function Coverage: %.2f\n", fcvg*100.0f);
   fflush(stderr);
   free(funcs);
   free(cfg_orig);
   return 0;
}

int64_t timespecDiff(struct timespec *timeA_p, struct timespec *timeB_p)
{
     return ((timeA_p->tv_sec * 1000000000) + timeA_p->tv_nsec) -
                   ((timeB_p->tv_sec * 1000000000) + timeB_p->tv_nsec);
}

int main(int argc, char **argv) {
   int status;
   pid_t listen, prog;
   struct timespec start, end;
   unlink(FIFO);
   if (mkfifo(FIFO, 0666) != 0) {
      fprintf(stderr, "mkfifo failed\n");
      return 1;
   }
   unsigned char ready = 0;
   if (argc < 3) {
      fprintf(stderr, "Usage: ./coverage_run <target program> <target cfg>\n");
      return 1;
   }
   if ((listen = fork())) { // parent
      clock_gettime(CLOCK_MONOTONIC, &start);
      if ((prog = fork())) { // parent
         waitpid(prog, NULL, 0);
         clock_gettime(CLOCK_MONOTONIC, &end);
         waitpid(listen, &status, 0);
         fflush(stderr);
         fprintf(stderr, "Program under test took %f ms\n",
               timespecDiff(&end, &start) / 1000000.0);
         if (!WIFEXITED(status) || WEXITSTATUS(status)) {
            fprintf(stderr, "Listener exited with status %d\n", WEXITSTATUS(status));
            return 1;
         }
         return 0;
      }
      else { // child
         return execvp(argv[1], argv+1);
      }
   }
   else { // child
      return listener_main(argv[2]);
   }
}
