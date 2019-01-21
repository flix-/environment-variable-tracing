#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s4 {
    char *t1;
    char *t2;
};

struct s3 {
    struct s4 s4;
};

struct s2 {
    char *t2;
    int b;
    struct s3 s3;
};

struct s1 {
    int a;
    struct s2 s2;
    char *t1;
};

int
main()
{
    struct s1 s1;
    s1.t1 = getenv("gude");

    int is_env_set = s1.t1 != NULL;

    if (is_env_set) {
        struct s2 s2_ut;
        s1.s2 = s2_ut;
    }

    struct s1 *s11 = &s1;
    struct s2 *s2 = &s1.s2;
    struct s3 *s3 = &s1.s2.s3;
    struct s4 *s4 = &s1.s2.s3.s4;

    int ut1 = s11->a;
    int t1 = s11->s2.b;

    char *t2 = s11->s2.t2;
    char *t3 = s2->t2;
    char *t4 = s2->s3.s4.t2;
    char *t5 = s3->s4.t1;
    char *t6 = s3->s4.t2;

    s3 = NULL;

    char *ut2 = s3->s4.t1;
    char *ut3 = s3->s4.t2;

    return 0;
}

