extern char *getenv(const char *name);
extern int foo();
extern int bar();

union u3 {
    char *taint;
    char *tainted;
};

union u2 {
    char *taint;
    double d;
    union u3 u;
};

union u1 {
    union u2 u;
    char *taint;
};

int
main()
{
    union u1 u;
    u.u.u.taint = getenv("hi");

    char *a = u.u.u.tainted;

    return 0;
}

