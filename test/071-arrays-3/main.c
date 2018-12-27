extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int numbers[2];
    numbers[0] = getenv("gude");
    numbers[1] = numbers[0];

    int rc = numbers[1];

    numbers[0] = 0;
    numbers[1] = numbers[0];

    rc = numbers[1];

    return rc;
}

