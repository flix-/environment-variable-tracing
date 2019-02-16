extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc; 
    int taint = getenv("gude");
    switch (taint) {
    default:
        ;
        rc = 1;
    case 0:
        ;
        int a = 1;
        break;
    }

    int no_taint = 0;

    return rc;
}

