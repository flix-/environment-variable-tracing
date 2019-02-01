#include <stdlib.h>
#include <stdio.h>

int
foo(char *t, char *ut) {


        if (t == NULL || ut == NULL) {
            do {
            } while (0);
        }


    int a = 0;

    return 1;
}

int
main() {
    char *tainted = getenv("gude");

    int rc = foo(tainted, "ploink");

    return 0;
}

