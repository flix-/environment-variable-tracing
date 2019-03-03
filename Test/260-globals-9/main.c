#include <stdlib.h>

extern char *getenv(const char *);

char *str[1024][1024];

int
main() {
    str[42][46] = getenv("gude");
    char *t = str[42][46];

    char *strl[1024][1024];
    strl[42][46] = getenv("gude");

    char *t2 = strl[42][46];

    return 0;
}

