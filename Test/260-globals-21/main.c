#include <stdlib.h>

extern char *getenv(const char *);
extern int foo();
extern int bar();

char *gt; 

int
main() {
    gt = getenv("gude");

    int t = (gt != NULL || foo()) ^ bar();

    int t2 = t;

    return 0;
}

