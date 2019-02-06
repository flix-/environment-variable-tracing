#include "util.h"

#include <stdlib.h>

static void
ploink()
{
    ;
}

int
foo(struct config *config)
{
    char *t = getenv("gude");
    ploink();

    return config->a;
}

void
bar(struct config *config)
{
    ploink();
}

