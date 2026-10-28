#ifdef _WIN32
    #define NGHTTP2_NO_SSIZE_T
#endif

#include <nghttp2/nghttp2.h>
#include <stdio.h>

static int on_data_chunk_recv_callback(nghttp2_session *session,
                                       uint8_t flags, int32_t stream_id,
                                       const uint8_t *data, size_t len,
                                       void *user_data) {
    return 0;
}

int main() {
    nghttp2_session_callbacks *callbacks;
    nghttp2_session *session;

    if (nghttp2_session_callbacks_new(&callbacks) != 0) {
        return 1;
    }

    nghttp2_session_callbacks_set_on_data_chunk_recv_callback(callbacks, on_data_chunk_recv_callback);
    int result = nghttp2_session_client_new(&session, callbacks, NULL);
    nghttp2_session_callbacks_del(callbacks);

    if (result != 0) {
        fprintf(stderr, "Test failed: session creation failed: %s\n", nghttp2_strerror(result));

        return 1;
    }

    nghttp2_session_del(session);

    return 0;
}
