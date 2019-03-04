extern char *getenv(const char *name);

int
main()
{
    char *str[2];
    str[1] = getenv("gude");

    if (str) {
        int t = 0;
    }

    return 0;
}

