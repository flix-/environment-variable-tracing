extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int taint = getenv("gude") == 0 ? 0 : foo();
    int a = taint;

    int ut = 1;

    return 0;
}

