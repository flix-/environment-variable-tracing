extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int taint = foo() == 0 ? getenv("gude") : bar();
    int a = taint;

    return 0;
}

