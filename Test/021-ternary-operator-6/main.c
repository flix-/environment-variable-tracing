extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int taint = foo() == 0 ? bar() : getenv("gude");
    int a = taint;

    return 0;
}

