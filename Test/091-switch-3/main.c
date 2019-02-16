extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc; 
    int taint = getenv("gude");
    switch (rc) {
    case 0:
        switch (taint) {
        case 0:
            ;
            int a = 1;
            break;
        case 1:
            ;
            int b = 2;
            break;
        default:
            ;
            rc = 3;
        }
        int f = 1;
        break;
    case 1:
        ;
        int a = 1;
        break;
    default:
        ;
        int b = 2;
    }

    int no_taint = 1;

    return rc;
}

