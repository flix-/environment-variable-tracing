#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s1 {
    char *t1;
    char *t2;
};

int
main()
{
    struct s1 s11;
    s11.t1 = getenv("gude");
    s11.t2 = getenv("gude");

    struct s1 *s12 = &s11;
    char *t1 = s12->t1;
    char *t2 = s12->t2;

    s11.t1 = "noe";

    s12 = &s11;
    char *ut1 = s12->t1;
    char *t3 = s12->t2;

    return 0;
}

