#include <stdlib.h>

extern char *getenv(const char *);
extern int foo();
extern int bar();

char *gt; 
char *gt2;

int
main() {
    gt = getenv("gude");

    if ((gt != NULL || foo()) ^ bar()) {
        int a = 0;

        while (a) {
            gt2 = "hi";
        }
    }

    char *t1 = gt;
    char *t2 = gt2;

    return 0;
}

