extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc;
    int taint = getenv("gude");

    if (foo()) {
        if (taint) {
            if (foo()) {
                rc = 1;
            } else {
                rc = 1;
            }
            rc = 1;
        } else {
            rc = 1;
        }
        int a = 100;
    } else {
        if (foo()) {
            rc = 1;
        } else {
            if (foo()) {
                rc = 100;
            }
            else if (taint) {
                int a = 100;
                int b = 200;
            } else {
                int a = 100;
            }
            int a = 100;
        }
    }
    int a = 1;

    return rc;
}

