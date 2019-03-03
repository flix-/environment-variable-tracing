#include <stdlib.h>

extern char *getenv(const char *);

union u1 {
    char *t;
    char *ut;
};

union u1 u1;

int
main() {
    u1.t = getenv("gude");
    char *t1 = u1.t;
    char *t2 = u1.ut;

    u1.ut = "nope";
    char *ut1 = u1.t;
    char *ut2 = u1.ut;

    return 0;
}

