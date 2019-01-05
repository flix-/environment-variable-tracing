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

struct s1 {
    union u1 u;
    union u3 uuu;
};

int
main()
{
    struct s1 s;
    s.u.u.u.taint = getenv("hi");
    s.uuu.taint = "no_taint";

    char *tainted = s.u.u.u.taint;
    char *not_tainted = s.uuu.taint;

    return 0;
}

