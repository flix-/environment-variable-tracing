#include <stdlib.h>

extern char *getenv(const char *);

struct s1 {
    char *t;
    int a;
    int b;
};

struct s2 {
    struct s1 s;
    char *t;
};

struct s1 s;

int
main() {
    s.t = getenv("gude");

    struct s2 s2;
    s2.s.t = s.t;
    s2.s.a = s.a;
    s2.s.b = s.b;

    return 0;
}

