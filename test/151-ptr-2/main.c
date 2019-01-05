extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *a = getenv("hi");
    char *b = "gude";

    char **c = &a;
    char *tainted1 = *c;
    char **tainted = c;
    char ***tainted2 = &c;

    *c = b;

    char *not_tainted1 = *c;
    char **not_tained2 = c;
    char ***not_tained3 = &c;

    return 0;
}

