extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int tainted = getenv("hi");
    int taint = foo() == 0 ? bar() : &tainted;
    int a = taint;

    int ut = 1;

    return 0;
}

