extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    while (getenv("gude")) {
        rc = 100;
        while (foo()) {
            rc = 42;
        }
        rc = 1;
    }

    return rc;
}

