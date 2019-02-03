#include <stdlib.h>

extern char *getenv(const char *);

int
main() {
    char *tainted = getenv("gude");

    int rc;
    if (tainted) {
        int b = 0;
        abort();
    } else {
        rc = 0;
    }

    int ut = 1;

    return rc;
}

