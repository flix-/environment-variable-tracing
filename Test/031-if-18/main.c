#include <stdlib.h>
#include <stdio.h>

int
main() {
    char *tainted = getenv("gude");

    int rc;
    if (rc != 0) {
        if (tainted != NULL) {
            if (tainted != NULL) {
                do {
                    int a = 0;
                } while (0);
            } else {
                return -1;
            }
            rc = 1;
        } else {
            return -1;
        }
    } else {
        if (rc == 1) {
            return -1;
        }
        char *t1 = tainted;
    }

    return rc;
}

