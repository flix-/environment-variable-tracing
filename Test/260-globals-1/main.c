#include <stdlib.h>

extern char *getenv(const char *);

char *gt; 
int a = 1;

int
main() {
    gt = getenv("gude");

    char *t = gt;

    gt = NULL;

    char *nt = gt;

    return 0;
}

