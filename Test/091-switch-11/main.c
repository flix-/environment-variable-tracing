#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc; 

    int a,b,c;

    switch((int)((a || (b && c)) && (getenv("gude") != NULL))) {
    case 0:
        ;
        switch (a) {
        case 0:
            ;
            break;
        case 1:
            ;
            break;
        case 2:
            ;
            break;
        default:
            ;
        }
        rc = 1;
        break;
    case 1:
        ;
        rc = 2;
        break;
    case 2:
        ;
        rc = 3;
    default:
        ;
        int t = 1;
        return -1;
    }

    int ut = 1;

    return rc;
}

