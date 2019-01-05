extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *a = getenv("hi");
    char **b = &a;

    *b = "hi";

    char **not_tainted = b;

    return 0;
}

