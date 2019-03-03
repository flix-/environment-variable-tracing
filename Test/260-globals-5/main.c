#include <stdlib.h>

extern char *getenv(const char *);

struct s2 {
    char *t;
    int a;
    int b;
};

struct s1 {
    struct s2 s;
    char *t;
};

struct s2 s2;

int
main() {
    struct s1 s1;
    s1.s.t = getenv("gude");

    s2 = s1.s;

    char *t1 = s2.t;
    int nt1 = s2.a;
    int nt2 = s2.b;

    return 0;
}

