#include <stdlib.h>

extern char *getenv(const char *);

struct s4 {
    char *t;
};

struct s3 {
    struct s4 s;
    int a;
};

struct s2 {
    char *t;
    int a;
    int b;
    struct s3 s;
};

struct s1 {
    struct s2 s;
    char *t;
};

struct s1 gs1;
struct s2 gs2;
struct s3 gs3;
struct s4 gs4;

int
main() {
    struct s1 s1;
    s1.s.s.s.t = getenv("gude");

    gs1 = s1;
    gs2 = s1.s;
    gs3 = s1.s.s;
    gs4 = s1.s.s.s;

    char *t1 = gs1.s.s.s.t;
    char *t2 = gs2.s.s.t;
    char *t3 = gs3.s.t;
    char *t4 = gs4.t;

    gs1.s.s = s1.s.s;
    char *t5 = gs1.s.s.s.t;

    gs3.s.t = "nope";

    struct s4 s4 = gs3.s;

    char *nt = s4.t;

    gs1.s.s = gs2.s;
    char *t6 = gs1.s.s.s.t;

    gs1.s.s = gs3;
    char *nt2 = gs1.s.s.s.t;

    return 0;
}

