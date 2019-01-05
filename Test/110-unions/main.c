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
    un.taint = "hello world";

    return 0;
}

