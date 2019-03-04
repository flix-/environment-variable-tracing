#include <stdlib.h>

extern char *getenv(const char *);

struct s1 {
    char *t1;
};

struct s1
foo() {
    int a = 0;
    struct s1 s1;
    s1.t1 = getenv("gude");

    if (a) {
        return s1;
    }

    char *t = getenv("gude");
    if (t != NULL) {
        return s1;
    }

    return s1;
}

int
main() {
    struct s1 s = foo();

    return -1;
}

