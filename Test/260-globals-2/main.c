#include <stdlib.h>

extern char *getenv(const char *);

struct s1 {
    char *t;
    int a;
    int b;
};

struct s1 s;

int
main() {
    s.t = getenv("gude");

    char *t = s.t;
    int nt1 = s.a;
    int nt2 = s.b;

    s.t = NULL;

    char *nt3 = s.t;

    return 0;
}

