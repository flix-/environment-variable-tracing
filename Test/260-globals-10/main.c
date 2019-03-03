#include <stdlib.h>

extern char *getenv(const char *);

struct s3 {
    char *t1;
};

struct s2 {
    int a;
    char *t1;
    struct s3 s3;
    char *ut;
};

struct s1 {
    char *t1;
    struct s2 *s2;
};

struct s1 gs1;
struct s2 gs2;
struct s3 gs3;

int
main() {
    struct s2 *s2 = malloc(sizeof *s2);
    if (!s2) return -1;

    gs1.s2 = s2;

    gs1.s2->s3.t1 = getenv("gude");

    gs2 = *gs1.s2;
    gs3 = gs2.s3;

    gs2.t1 = gs1.s2->ut;

    char *t1 = gs3.t1;
    char *t2 = gs2.s3.t1;
    char *t3 = gs1.s2->s3.t1;

    gs3.t1 = "nope";
    char *ut1 = gs3.t1;

    char *t4 = gs2.s3.t1;
    gs2.s3.t1 = "nope";

    char *ut2 = gs2.s3.t1;

    return 0;
}

