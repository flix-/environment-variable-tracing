extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc; 
    int taint = getenv("gude");
    switch (taint) {
    case 0:
        ;
        rc = 1;
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

