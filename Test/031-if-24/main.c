#include <stdlib.h>
#include <stdio.h>

int
main() {
    int a,b,c,d;

    int rc;

    if ((a == 0
        || b == 1
        || c == 2)
        && getenv("gude") != NULL) {

        if (!d) goto err;

        rc = 1;
    } else {
        if (!d) goto err;
        rc = 1;
    }

    int ut = 1;

err:
    return rc;
}

