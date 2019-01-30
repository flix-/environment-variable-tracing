#include <stdlib.h>

extern char *getenv(const char *);

int
main() {
    char *tainted = getenv("gude");

    if (tainted) {
        int a = 0;
        abort();
    }

    int a = 0;

    return 0;
}

