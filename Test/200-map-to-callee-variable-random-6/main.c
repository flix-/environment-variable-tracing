#include <stdlib.h>

extern char *getenv(const char *name);

struct s2 {
    char *t1;
    char *t2[2];
};

struct s1 {
    int a;
    int b;
    struct s2* s2;
};

void
bar(char *t) {
    char *t2 = t;
}

void
foo(char *t2[])
{
    char *t1 = t2[1];
    char *ut1 = t2[0];

    bar(t1);
}

int
main()
{
    struct s1 s1;
    struct s2 s2;

    s2.t2[1] = getenv("gude");
    s1.s2 = &s2;

    foo(s1.s2->t2);

    return 0;
}

