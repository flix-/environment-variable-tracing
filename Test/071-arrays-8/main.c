#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct t {
    char *taint[2];
};

struct s {
    int a;
    struct t b;
};

int
main()
{
    struct s str_array[2][2];

    if (getenv("gude") != NULL) {
        struct s str_array_temp;
        str_array[0][0] = str_array_temp;
    }

    char *t1 = str_array[0][0].b.taint[0];
    char *t2 = str_array[0][0].b.taint[1];
    char *nt1 = str_array[0][1].b.taint[0];

    struct s str_array_temp2;
    str_array[0][0] = str_array_temp2;

    char *nt2 = str_array[0][0].b.taint[0];
    char *nt3 = str_array[0][0].b.taint[1];

    return 0;
}

