#include <stdlib.h>

extern char *getenv(const char *);

int
main() {
    char *tainted = getenv("gude");

    int rc;
    if (tainted) {
        rc = 0;
        abort();
    }

    int t = 0;

    return rc;
}

