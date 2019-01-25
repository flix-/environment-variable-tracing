#include <stdlib.h>

extern char *getenv(const char *name);

struct s2 {
    int a;
};

struct s1 {
    struct s2 s2;
};

void
foo(int a)
{
    int t1 = a;
}

int
main()
{
    struct s1 s1;
    char *tainted = getenv("gude");
    s1.s2.a = tainted != NULL;

    foo(s1.s2.a);

    return 0;
}

