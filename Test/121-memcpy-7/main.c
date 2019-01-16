#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s2 {
    char *t2;
    int *i;
};

struct s1 {
    char *t1;
    struct s2 s2;
};

int
main()
{
    struct s1 s;
    struct s2 s2;

    s.s2.t2 = getenv("gude");

    memcpy(&s2, &s, 1024);

    char *t1 = s2.t2;

    s.s2.t2 = "untaint";
    char *nt1 = s.s2.ts;

    char *t2 = s2.t2;

    return 0;
}

