extern char *getenv(const char *name);
extern int foo();
extern int bar();

union u2 {
    int a;
    char *taint;
};

struct s2 {
    union u2 u[2];
};

union u1 {
    int a;
    double b;
    struct s2 s;
};

struct s1 {
    char *taint;
    union u1 u;
    int a;
};

int
main()
{
    struct s1 s;
    s.u.s.u[0].taint = getenv("hello world");
    char *also_tainted = s.u.s.u[0].taint;

    s.u.s.u[0].a = 1;
    char *not_tainted = s.u.s.u[0].taint;

    return 0;
}

