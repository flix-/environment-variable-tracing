#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s2 {
    char *t2;
    int a;
};

struct s1 {
    char *t1;
    struct s2 s2;
};

int
main()
{
    int rc;
    struct s1 s1;
    s1.s2.t2 = getenv("gude");

    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < (s1.s2.t2 != NULL); j++) {
            struct s2 s2;
            s1.s2 = s2;
        }
        rc = s1.s2.a;

        struct s2 s2nt;
        s1.s2 = s2nt;

        int nt1 = s1.s2.a;
        char *nt2 = s1.s2.t2;
    }

    return rc;
}

