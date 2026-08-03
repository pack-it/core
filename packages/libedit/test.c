#include <stdio.h>
#include <stdlib.h>
#include <histedit.h>

int main() {
    EditLine* editline = el_init("test", stdin, stdout, stderr);
    if (editline == NULL) {
        return 1;
    }

    int count;
    const char *line = el_gets(editline, &count);
    if (line == NULL) {
        // Free memory
        el_end(editline);
        return 1;
    }

    printf("packit> %s", line);

    // Free memory
    el_end(editline);
}
