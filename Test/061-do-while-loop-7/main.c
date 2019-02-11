#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    do {
        do {
            int a;
            do {
                a = 1;
                while (a) {
                    int b = 0;
                    if (b == 1) goto err;
                }
                if (a != 1) continue;
            } while (getenv("gude") != NULL);
            rc = a;
            int ut = 0;
        } while (foo());
    } while (bar());

    for (int i = 0; getenv("gude") != NULL; ++i) {
        int a = i;
    }

err:
    ;
    int ut1 = 0;

    return rc;
}

