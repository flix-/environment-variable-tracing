extern int getenv(const char *name);
extern int foo();
extern int bar();
int taint;
int
main()
{
    int rc; 
    int untainted;
    taint = getenv("gude");

    if (rc) {
        if (taint) {
            switch (rc) {
            default:
                ;
                rc = 1;
            case 0:
                switch (rc) {
                default:
                    ;
                    if (bar()) {
                        int a = 2;
                    } else if (foo() || bar()) {
                        int a = 1;
                    } else {
                        int a = 3;
                    }
                    rc = 1;
                case 0:
                    ;
                    if (taint) {
                        int a = 2;
                    } else if (foo() == 0 ? 0 : 1) {
                        int a = 1;
                    } else {
                        int a = 3;
                    }
                    int a = 1;
                    break;
                }
                int a = 1;
                break;
            }
        }
        int eot = 0;
    }
    int a = 0;

    if (untainted) {
        a = 1;
    } else {
        a = 2;
    }

    switch (rc) {
    case 0:
        ;
        int a = 0;
        break;
    }

    return rc;
}

