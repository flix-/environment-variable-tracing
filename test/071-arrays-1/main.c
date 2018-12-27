extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int numbers[2];
    numbers[0] = getenv("gude");
    numbers[1] = 1;

    int rc = numbers[0];

    return rc;
}

