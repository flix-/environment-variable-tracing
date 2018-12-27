extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int ret;
    if (foo()) {
        if (getenv("gude")) {
            int a = 100;
            ret = a;
        } else {
            ret = 100;
        }
    } else {
        ret = 100;
    }

    return ret;
}

