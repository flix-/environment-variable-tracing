extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    while (foo()) {
        rc = 100;
        while (getenv("gude")) {
            rc = 42;
        }
    }

    return rc;
}

