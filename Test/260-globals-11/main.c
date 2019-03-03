#include <stdlib.h>

extern char *getenv(const char *);

struct s2 {
    int a;
    char *t1;
    char *ut;
};

struct s1 {
    char *t1;
    struct s2 *s2;
};

struct s1 s1;

int
foo(struct s1 s1, struct s2 *sp2, struct s2 s2) {
    char *t1 = s1.s2->t1;
    char *t2 = sp2->t1;
    char *t3 = s2.t1;

    char *ut1 = s1.s2->ut;
    char *ut2 = sp2->ut;
    char *ut3 = s2.ut;

    return 0;
}

int
main() {
    struct s2 *s2 = malloc(sizeof *s2);
    if (!s2) return -1;

    s1.s2 = s2;

    s1.s2->t1 = getenv("gude");

    int rc = foo(s1, s1.s2, *s1.s2);

    return rc;
}

