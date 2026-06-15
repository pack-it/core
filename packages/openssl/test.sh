#!/bin/sh

test_input="I hashed the previous version of this script, unfortunately the hash was my only backup. Whoops!"

# This hash does not match the hash on Windows, due to line ending differences
expected_output="SHA2-256(stdin)= 38517b49c926cb5178a28c388075b9caeca07cc52c398d4419c2fa6f98947c7b"
output=$(echo "$test_input" | "$PACKIT_PACKAGE_PATH/bin/openssl" sha256 -hex)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: sha256 hashing test did not output the expected hash"
    exit 1
fi

output=$("$PACKIT_PACKAGE_PATH/bin/openssl" verify test.pem 2>&1 || true)

if ! echo "$output" | grep -q "verification failed"; then
    echo "Test failed: verifying an invalid certificate did not result in a failed verification"
    exit 1
fi
