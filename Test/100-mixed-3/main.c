#include "stdlib.h"

extern char *getenv(const char *);

int
foo(char *in) {
    int len;

    in += len;
    char *t1 = in;

    return 0;
}

int
main() {
    int a, b, c;

    char *p = getenv("gude");

    if (getenv("gude") != NULL) {
        if (!foo(p)) return 0;
    }

    return 0;
}

