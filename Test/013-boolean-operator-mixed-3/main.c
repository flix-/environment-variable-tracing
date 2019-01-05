extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int taint = (!getenv("hi") && foo()) || getenv("gude");
    int a = taint;

    return 0;
}

