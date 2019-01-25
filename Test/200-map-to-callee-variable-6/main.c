#include <stdlib.h>

extern char *getenv(const char *name);

void
foo(int a)
{
    int t1 = a;
}

int
main()
{
    char *tainted = getenv("gude");
    int is_env_set = tainted != NULL;

    foo(is_env_set + 1);

    return 0;
}

