#include <stdlib.h>

extern char *getenv(const char *);

int
main() {
    char *tainted = getenv("gude");

    if (tainted) {
        int a = 0;
        char *t1 = getenv("huhu");
        abort();
    } else {
        int b = 1;
        abort();
    }

    char *nt = tainted;

    return 0;
}

