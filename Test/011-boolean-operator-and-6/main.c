extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int tainted = getenv("hi");
    int taint = &tainted && !&tainted;
    int a = taint;

    return 0;
}

