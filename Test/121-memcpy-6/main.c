#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s3 {
    int i1;
    int i2;
    int i3;
    char *t3;
};

struct s2 {
    int i1;
    char *t2;
    struct s3 s3;
};

struct s1 {
    char *t1;
    struct s2 s2;
};

int
main()
{
    struct s1 s11;
    s11.s2.s3.t3 = getenv("gude");

    struct s1 s12;
    memcpy(&s12, &s11, 1024);

    char *t1 = s12.s2.s3.t3;

    struct s2 s2;
    memcpy(&s2, &s11.s2, 1024);

    char *t2 = s2.s3.t3;

    struct s3 s3;
    memcpy(&s3, &s11.s2.s3, 1024);

    char *t3 = s3.t3;

    char *t4;
    memcpy(&t4, &s11.s2.s3.t3, 1024);

    char *t5 = t4;

    struct s1 s13;
    memcpy(&s13.s2.t2, &s11.s2.s3.t3, 1024);
    char *t6 = s13.s2.t2;
    char *nt1 = s13.t1;

    return 0;
}

