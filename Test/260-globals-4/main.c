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

struct s1 s1;

int
main() {
    s1.s.t = getenv("gude");

    struct s2 s2;
    s2.t = s1.s.t;
    s2.a = s1.s.a;
    s2.b = s1.s.b;

    return 0;
}

