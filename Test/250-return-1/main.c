#include <stdlib.h>

extern char *getenv(const char *);

int
foo() {
    char *t = getenv("gude");

    return t != NULL;
}

int
main() {
    return foo();
}

