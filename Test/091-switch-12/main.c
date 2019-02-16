#include <stdlib.h>

int main() {
    int rc;

    switch((int)getenv("gude")) {
    case 0:
        ;
        rc = 1;
        /* FALLTHROUGH */
    case 1:
        ;
        rc = 2;
        /* FALLTHROUGH */
    default:
        ;
        int taint = 1;

        goto err;
    }

    int ut6 = 1;

err:
    ;
    int no_taint = 1;

    return rc;
}

