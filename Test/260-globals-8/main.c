#include <stdlib.h>

extern char *getenv(const char *);

struct s3 {
    char *t1;
    int a;
    char *t2;
};

union u1 {
    char *t;
    int a;
    char *ut;
    struct s3 s3;
};

struct s2 {
    union u1 u;
    char *t;
};

struct s1 {
    char *t;
    struct s2 s2;
};

struct s1 s1;

int
main() {
    s1.s2.u.s3.t2 = getenv("gude");
    char *t1 = s1.s2.u.s3.t2;

    s1.s2.u.ut = "noe";

    char *t2 = s1.s2.u.s3.t2;

    return 0;
}

