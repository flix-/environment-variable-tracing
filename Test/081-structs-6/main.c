extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct b {
    char *taint;
};

struct a {
    int a;
    struct b b;
};

int
main()
{
    struct a s1;
    s1.b.taint = getenv("hi");

    char *tainted = s1.b.taint;

    struct b s2_inner;
    s1.b = s2_inner;

    char *not_tainted = s1.b.taint;

    return 0;
}

