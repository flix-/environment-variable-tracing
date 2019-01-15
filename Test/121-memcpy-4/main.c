#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s2 {
    char *tainted;
    char *untainted;
};

struct s1 {
    int a;
    struct s2 s;
    char *tainted;
};

int
main()
{
    struct s1 s;
    struct s1 s2;
    s.s.tainted = getenv("hi");

    memcpy(&s2, &s, 1024);

    char *tainted = s2.s.tainted;
    char *not_tainted = s2.tainted;

    return 0;
}

