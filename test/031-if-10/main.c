extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    int untainted;
    int taint = getenv("gude");

    if (taint) {
        if (foo()) {
            rc = 1;
        } else {
            rc = 1;
        }
    } else {
        if (foo()) {
            rc = 1;
        } else {
            rc = 1;
        }
    }
    int a = 1;
    
    if (untainted) {
        a = 0;
    } else {
        a = 1;
    }

    return rc;
}

