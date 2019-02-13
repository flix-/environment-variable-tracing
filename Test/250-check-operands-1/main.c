#include "stdlib.h"

extern char *getenv(const char *);

struct s1 {
    char *tainted;
    char *not_tainted;
};

int
main() {
    struct s1 *s1 = malloc(sizeof *s1);
    s1->tainted = getenv("gude");

    int t1 = (int)s1 + 1;
    int t2 = (int)s1->tainted + 1;
    int ut1 = (int)s1->not_tainted + 1;

    return -1;
}

