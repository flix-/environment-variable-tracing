extern char *getenv(const char *name);

int
main()
{
    char *a = getenv("GUDE");
    char **b = &a;
    *b = "UNGUDE";

    char *c = a;    // this must not be a tainted value

    return 0;
}

