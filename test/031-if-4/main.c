extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int ret;
    if (foo()) {
        int a = getenv("gude");
        ret = a;
    } else {
        ret = 100;
    }

    return ret;
}

