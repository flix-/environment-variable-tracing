extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    while (getenv("gude") && foo()) {
        rc = 100;
    }

    return rc;
}

