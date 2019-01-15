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

    char *tainted1 = s2.s.tainted;
    char *not_tainted1 = s2.tainted;

    s.s.tainted = "untaint";
    char *not_tainted2 = s.s.tainted;

    char *tainted2 = tainted1;
    char *tainted3 = s2.s.tainted;

    return 0;
}

