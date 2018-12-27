extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    for (int i = 0; getenv("gude") && foo(); i++) {
        rc = i;
    }

    return rc;
}

