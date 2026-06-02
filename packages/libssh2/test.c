#include <stdio.h>
#include <libssh2.h>

int main(void) {
    int rc;

    rc = libssh2_init(0);
    if (rc != 0) {
        fprintf(stderr, "libssh2_init failed: %d\n", rc);
        return 1;
    }

    LIBSSH2_SESSION *session = libssh2_session_init();
    if (session == NULL) {
        fprintf(stderr, "libssh2_session_init failed\n");
        libssh2_exit();
        return 1;
    }

    libssh2_session_free(session);
    libssh2_exit();

    return 0;
}
