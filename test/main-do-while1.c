extern char *getenv(const char *name);

int
main()
{
    char *env;
    char *a;
    do {
        env = a;
    } while ((a = getenv("foo")) == 0);

    char *b = env;

    return 0;
}

