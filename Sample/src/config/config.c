#include "config.h"

#include <stdlib.h>

static struct config *
load_config(char *path)
{
    struct config *config = malloc(sizeof *config);
    if (!config) return NULL;

    // load...

    config->path = path;
    config->a = 0;
    config->b = 1;
    config->c = 2;

    return config;
}

struct config *
get_config()
{
    int is_getenv_used = 0;

    char *config_path = getenv("SAMPLE_CONFIG");
    if (config_path) {
        is_getenv_used = 1;
    } else {
        config_path="/tmp";
    }

    struct config *c = load_config(config_path);

    return c;
}

void
free_config(struct config *config)
{
    free(config);
}

