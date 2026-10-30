// See: https://nghttp2.org/ngtcp2/programmers-guide.html#creating-ngtcp2-conn-object
// See: https://github.com/ngtcp2/ngtcp2/blob/main/examples/client.cc
#include <stdio.h>
#include <ngtcp2/ngtcp2.h>
#include <ngtcp2/ngtcp2_crypto.h>

static void rand_cb(uint8_t *dest, size_t destlen, const ngtcp2_rand_ctx *rand_ctx) {}

static int get_new_connection_id_cb(ngtcp2_conn *conn, ngtcp2_cid *cid, ngtcp2_stateless_reset_token *token, size_t cidlen, void *user_data) {
    return 0;
}

int main() {
    ngtcp2_conn *connection = NULL;
    ngtcp2_callbacks callbacks = {
        .client_initial = ngtcp2_crypto_client_initial_cb,
        .recv_crypto_data = ngtcp2_crypto_recv_crypto_data_cb,
        .encrypt = ngtcp2_crypto_encrypt_cb,
        .decrypt = ngtcp2_crypto_decrypt_cb,
        .hp_mask = ngtcp2_crypto_hp_mask_cb,
        .recv_retry = ngtcp2_crypto_recv_retry_cb,
        .update_key = ngtcp2_crypto_update_key_cb,
        .delete_crypto_aead_ctx = ngtcp2_crypto_delete_crypto_aead_ctx_cb,
        .delete_crypto_cipher_ctx = ngtcp2_crypto_delete_crypto_cipher_ctx_cb,
        .get_path_challenge_data2 = ngtcp2_crypto_get_path_challenge_data2_cb,
        .version_negotiation = ngtcp2_crypto_version_negotiation_cb,

        .rand = rand_cb,
        .get_new_connection_id2 = get_new_connection_id_cb,
    };

    ngtcp2_cid dcid, scid;
    ngtcp2_cid_init(&dcid, (const uint8_t *)"1", 1);
    ngtcp2_cid_init(&scid, (const uint8_t *)"2", 1);

    ngtcp2_settings settings;
    ngtcp2_settings_default(&settings);

    ngtcp2_transport_params params;
    ngtcp2_transport_params_default(&params);
    params.original_dcid_present = 0;

    ngtcp2_path path = {0};

    int result = ngtcp2_conn_client_new(
        &connection,
        &dcid,
        &scid,
        &path,
        NGTCP2_PROTO_VER_V1,
        &callbacks,
        &settings,
        &params,
        NULL,
        NULL
    );

    if (result) {
        fprintf(stderr, "Test failed: creating client connection failed\n");
        ngtcp2_conn_del(connection);
        return 1;
    }

    ngtcp2_conn_del(connection);
    return 0;
}
