#include <stdlib.h>

int main() {
    int a,b,c,d,e,rc;

    if (a) {
        switch((int)getenv("gude")) {
        case 0:
            ;
            int taint = 1;
            break;
        case 1:
            ;
            int taint2 = 2;
            /* FALLTHROUGH */
        default:
            goto err;
        }

        if (b) {
            while (a != 4711) {
                for (int i = 0; i < (getenv("gude") == NULL); ++i) {
                    do {
                        while (getenv("gude") != NULL) {
                            if ((getenv("gude") && a && b && c) || e) {
                                if (a) {
                                    do {
                                        int a = 0;
                                    } while (0);
                                } else {
                                    int b = 1;
                                }
                            } else if (a || b || c) {
                                int t = a;
                                if (!b) return -1;
                            } else {
                                int t = 1;
                            }
                            rc = 4711;
                        }
                        int end1 = 1;
                    } while (getenv("gude"));
                    int end2 = 1;
                }
            }
            int ut1 = 1;
            for (int j = 0; j < 42; ++j) {
                while ((a || b || c) && e != (int)getenv("gude")) {
                    int taint_me = 1;
                }
                int ut4 = 1;
            }
        } else if (getenv("gude") != NULL) {
            int t = 1;
        }

        int no_taint = 1;

        while (getenv("gude") != NULL) {
            if (no_taint == 1) break;
            int taint_me = 1;
            if (d) {
                goto err;
            } else {
                int t = 1;
            }
        }
    }
    int ut6 = 1;
err:
    ;
    int no_taint = 1;
    return rc;
}

