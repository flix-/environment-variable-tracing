extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    do {
        do {
            int a;
            do {
                a = 1;
            } while (getenv("gude"));
            rc = a;
            int ut = 0;
        } while (foo());
    } while (bar());

    return rc;
}

