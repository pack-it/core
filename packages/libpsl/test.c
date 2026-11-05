#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libpsl.h>

int main() {
    const psl_ctx_t *psl = psl_builtin();

    // Test if nl is correctly recognized as valid public suffix
    if (psl_is_public_suffix2(psl, "nl", PSL_TYPE_NO_STAR_RULE) != 1) {
        printf("Test failed: 'nl' should be a public suffix\n");
        return 1;
    }

    // Test if does-not-exist is correctly recognized as invalid public suffix
    if (psl_is_public_suffix2(psl, "does-not-exist", PSL_TYPE_NO_STAR_RULE) != 0) {
        printf("Test failed: 'does-not-exist' should not be a public suffix\n");
        return 1;
    }

    return 0;
}
