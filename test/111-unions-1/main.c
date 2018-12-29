extern char *getenv(const char *name);
extern int foo();
extern int bar();

union u1 {
    int a;
    double b;
    char *taint;
};

int
main()
{
    union u1 un;
    un.taint = getenv("hello world");

    char *a = un.taint;

    un.a = 1;

    char *b = un.taint;

    return 0;
}

