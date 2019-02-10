extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int a;
    int rc;
    do {
        rc = 42;
        do {
            rc = 1;
        } while (getenv("gude"));
        int end = 1;
    } while (foo());

    if (a) {
        int ut = 1;
    } else {
        int ut = 2;
    }

    return rc;
}

