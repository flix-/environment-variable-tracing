#include <stdlib.h>
#include <stdio.h>

extern int bar();
extern int ploink();

int
foo(char *t, char *ut) {
    if (t == NULL && ut == NULL) {
        do {
            int t = getenv("gude") ? bar() : ploink();
        } while (0);
    } else {
        int a = 1;
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

