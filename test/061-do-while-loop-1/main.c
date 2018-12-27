extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    do {
        rc = 42;
    } while (getenv("gude"));

    return rc;
}

