#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s2 {
    char *t2;
};

struct s1 {
    char *t1;
    struct s2 s2;
};

int
main()
{
    struct s1 s1;
    s1.t1 = getenv("gude");
    s1.s2.t2 = getenv("gude");

    memset(&s1.t1, 0, 3);

    char *t1 = s1.s2.t2;
    char *ut1 = s1.t1;

    return 0;
}

