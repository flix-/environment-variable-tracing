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
    union u2 uu;
    char *taint;
};

int
main()
{
    struct s1 s;
    s.taint = getenv("hi");

    char *tainted = s.taint;
    char *not_tainted = s.u.u.u.tainted;

    s.u.taint = s.taint;
    tainted = s.u.taint;

    return 0;
}

