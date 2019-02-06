#ifndef CONFIG_H
#define CONFIG_H

struct config {
    char *path;
    int getenv_used;

    int a;
    int b;
    int c;
};

struct config *get_config();
void free_config();

#endif /* CONFIG_H */
