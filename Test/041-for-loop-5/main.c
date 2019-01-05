extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < getenv("gude"); j++) {
            rc = j;
        }
        rc = i;
    }

    return rc;
}

