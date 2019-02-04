#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc; 
    char *taint = getenv("gude");
    int is_env_set = taint != NULL;

    switch (is_env_set) {
    case 0:
        ;
        int a = 0;
        abort();
    case 1:
        ;
        rc = 1;
        break;
    default:
        switch (rc) {
        case 0:
            abort();
        default:
            abort();
        }
        abort();
    }

    char *ut1 = "huhu";

    return rc;
}

