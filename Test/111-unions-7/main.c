extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s2 {
    char *strings[2];
};

union u1 {
    char *taint;
    struct s2 s;
};

struct s1 {
    union u1 u;
    char *taint;
};

int
main()
{
    struct s1 s;
    s.u.s.strings[0] = getenv("hi");

    char *tainted = s.u.taint;
    s.u.s.strings[1] = "untaint";

    char *not_tainted = s.u.s.strings[0];
    char *not_tainted2 = s.u.s.strings[1];

    return 0;
}

