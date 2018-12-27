extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    do {
        rc = 42;
        do {
            rc = 1;
        } while (getenv("gude"));
    } while (foo());

    return rc;
}

