extern char *getenv(const char *name);
extern int foo();
extern int bar();

union u1 {
    char *t;
};

int
main()
{
    union u1 u;
    u.t = getenv("hi");

    union u1 uu = u;

    char *tainted = uu.t;

    uu.t = "untaint";

    char *not_tainted = uu.t;

    char *still_tainted = u.t;

    return 0;
}

