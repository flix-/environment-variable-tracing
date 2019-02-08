#include <stdlib.h>
#include <stdio.h>

int
main() {
    char *tainted = getenv("gude");
    int is_env_set = tainted != NULL;

    int rc;

    if (is_env_set) {
        if (rc != 0) {
            int a = 0;
            return -1;
        } else if (rc == 0) {
            return 0;
        } else {
            return 2;
        }
        return -1;
    } else {
        rc = 1;
    }

    int ut = 1;

    return rc;
}

