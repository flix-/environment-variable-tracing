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
        int a = 1;
        break;
    case 1:
        switch (rc) {
        case 0:
            ;
            rc = 1;
            break;
        case 1:
            ;
            rc = 2;
            break;
        }
    }
    int a = 0;

    return rc;
}

