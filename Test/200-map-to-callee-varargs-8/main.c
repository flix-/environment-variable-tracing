#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

struct s2 {
    char *t1;
    char *t2;
    char *ut1;
};

struct s1 {
    int a;
    int b;
    struct s2 s2;
};

void
foo(int n, ...)
{
    char *tainted = getenv("gude");

    if (tainted != NULL) {
        va_list ap;
        va_start(ap, n);

        struct s2 *s2 = va_arg(ap, struct s2*);

        char *t1 = s2->t1;
        char *t2 = s2->t2;
        char *ut1 = s2->ut1;

        va_end(ap);
    }
}

int
main()
{
    struct s2 s2;
    s2.t1 = getenv("gude");
    s2.t2 = s2.t1;

    foo(1, &s2);

    return 0;
}

