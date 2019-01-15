extern char *getenv(const char *name);
extern int foo();
extern int bar();

/*
 * If we have e.g. int ***ptr stored (store %x, %y (ptr to alloca)) then it
 * should not matter whether we are overwriting ptr, *ptr, **ptr or ***ptr.
 * Assuming the assigned value is not tainted then the store must be removed
 * no matter which hop in the load chain is overwritten (we simply cannot reach
 * the previously tainted end ***ptr anymore! *ptr, **ptr and so on just differs
 * in the amount of encapsulated load instructions.
 */

int
main()
{
    char *u = "untainted";
    char **pu = &u;
    char ***ppu = &pu;

    char *t = getenv("gude");
    char **pt = &t;
    char ***ppt = &pt;

    char *tainted = **ppt;

    **ppt = u;

    char **not_tainted = *ppt;

    return 0;
}

