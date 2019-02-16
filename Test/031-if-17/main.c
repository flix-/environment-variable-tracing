#include <stdlib.h>
#include <stdio.h>

int
main() {
    char *tainted = getenv("gude");

    int rc;
    if (tainted) {
        return -1;
    } else {
        int a = 0;
    }

    int t = 1;

    return rc;
}

