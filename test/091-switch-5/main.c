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
            switch (rc) {
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
                int c = 3;
            }
            int a = 1;
            break;
        case 1:
            ;
            int b = 2;
            break;
        default:
            ;
            int c = 3;
        }
        break;
    case 1:
        ;
        rc = 1;
        break;
    default:
        ;
        int b = 2;
    }

    return rc;
}

