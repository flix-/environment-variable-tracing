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
            int a = 1;
        } while (foo());
    } while (getenv("gude"));

    return rc;
}

