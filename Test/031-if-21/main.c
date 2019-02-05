#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();

int
main()
{
    int rc; 
    int ut1, ut2, ut3, ut4, ut5;
    char *taint; 

    if (taint[12] != 'a') return -1;

    if ((taint = getenv("gude")) != NULL) {
        int t = taint != NULL ? 0 : 1;

        if (ut1) {
            if (ut2) {
                int a = 0;
            }
        } else if (ut3) {
            int a = 0;
        }

        if (ut4) {
            int t = taint != NULL ? 0 : 1;

            if (ut5) {
                int a = 0;
            } else {
                int a = 0;
            }
        } else {
            int a = 0;
        }
    } else {
        rc = 0;
    }

    int nt = 1;

    return rc;
}

