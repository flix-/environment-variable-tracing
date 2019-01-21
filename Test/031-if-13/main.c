#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    char *t1 = getenv("gude");
    int is_env_set = t1 != NULL;

    if (is_env_set) {
        int a = 0;
        if (is_env_set) {
            rc = 1;
        } else {
            rc = 0;
        }
        int b = 0;
    }

    int a = 0;

    return rc;
}

