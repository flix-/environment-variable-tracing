#include <stdlib.h>

extern char *getenv(const char *);

int
main()
{
    int rc;
    int a;

    if (getenv("gude") != NULL) {
        char *a = malloc(sizeof a);
        if (!a) goto err;

        rc = 1;
    } else {
        a = 0;
    }
    int eob = 1;

    return 0;

err:
    ;
    int ut1 = 0;

    if (a) {
        int b = 1;
    } else {
        int c = 2;
    }

    int ut2 = 0;

    return rc;
}

