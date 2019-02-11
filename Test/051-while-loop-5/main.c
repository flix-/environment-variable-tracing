extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    while (getenv("gude")) {
        if (rc == 0) break;
        rc = 100;
    }

    int ut = 0;

    return rc;
}

