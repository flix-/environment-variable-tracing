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
                return -1;
            } else {
                int a = 1;
            }
            int eob = 1;
            return -1;
        } else {
            rc = 1;
        }
        int t = 2;
    } else {
        if (rc == 1) {
            return -1;
        }
        char *t1 = tainted;
    }

    char *ut = "gude";

    return rc;
}

