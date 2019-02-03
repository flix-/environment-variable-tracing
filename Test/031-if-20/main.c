extern int getenv(const char *name);
extern int foo();

int
main()
{
    int rc; 
    int taint = getenv("gude");

    if (taint == 0 ? 0 : 1) {
        int a = 2;
    } else {
        int a = 3;
    }

    int nt = 1;

    return rc;
}

