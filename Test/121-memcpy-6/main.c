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
    struct s2 ss;
    s.s.tainted = getenv("hi");

    memcpy(&ss, &s.s, 1024);

    return 0;
}

