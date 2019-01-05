#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *taint = getenv("gude");
    char *a = taint;

    char *b = a;
    a = "no_taint";

    b = a;

    return 0;
}

