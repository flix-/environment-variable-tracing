extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc; 
    int untainted;
    int taint = getenv("gude");
    switch (taint) {
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
    int a = 0;

    switch (untainted) {
    case 0:
        ;
        int a = 0;
        break;
    }

    return rc;
}

