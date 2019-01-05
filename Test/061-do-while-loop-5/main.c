extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    do {
        int a;
        do {
            a = 1;
        } while (getenv("gude"));
        rc = a;
    } while (foo());

    return rc;
}

