#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *s[3];
    s[1] = getenv("gude");

    char *d[3];

    memmove(d, s, 3);

    char *also_tainted = d[1];

    char *nt1 = d[0];
    char *nt2 = d[2];

    return 0;
}

