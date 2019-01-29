#include <stdlib.h>

extern char *getenv(const char *name);

void
bar(char *tainted_bar) {
    char *t1 = tainted_bar;
}

void
foo(char *tainted_foo)
{
    bar(tainted_foo);
}

int
main()
{
    char *tainted = getenv("gude");
    
    foo(tainted);

    return 0;
}

