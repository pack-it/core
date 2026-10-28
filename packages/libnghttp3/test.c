#ifdef _WIN32
    #define NGHTTP3_NO_SSIZE_T
#endif

#include <nghttp3/nghttp3.h>
#include <stdio.h>
#include <string.h>

static int on_data_receive(nghttp3_conn *connection,
                        int64_t stream_id,
                        const uint8_t *data,
                        size_t len,
                        void *connection_user_data,
                        void *stream_user_data)
{
    return 0;
}

int main() {
    nghttp3_callbacks callbacks = {0};
    nghttp3_settings settings;
    nghttp3_conn *connection = NULL;

    callbacks.recv_data = on_data_receive;
    nghttp3_settings_default(&settings);

    int result = nghttp3_conn_client_new(&connection, &callbacks, &settings, NULL, NULL);
    if (result != 0) {
        fprintf(stderr, "Test failed: session creation failed: %s\n", nghttp3_strerror(result));
        return 1;
    }

    nghttp3_conn_del(connection);
    return 0;
}
