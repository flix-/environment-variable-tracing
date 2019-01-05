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
        } else if (bar()) {
            ret = 100;
        } else {
            if (foo()) {
                ret = 100;
            }
        }
        ret = 100;
    } else {
        ret = 100;
    }

    return ret;
}

