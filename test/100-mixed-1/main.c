extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc; 
    int untainted;
    int taint = getenv("gude");

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
                    rc = 1;
                case 0:
                    ;
                    int a = 1;
                    break;
                }
                int a = 1;
                break;
            }
        }
        int u = 0;
    }
    int a = 0;

    if (untainted) {
        a = 1;
    } else {
        a = 2;
    }

    switch (untainted) {
    case 0:
        ;
        int a = 0;
        break;
    }

    return rc;
}

