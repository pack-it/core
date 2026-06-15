#!/bin/sh

test_input="I hashed the previous version of this script, unfortunately the hash was my only backup. Whoops!"

expected_output="SHA2-256(stdin)= a6a6ac959ebea1f5ec010438e2ccec6fbc73f1cc53797a02ae6cbf3cd9477e9a"
output=$(echo "$test_input" | "$PACKIT_PACKAGE_PATH/bin/openssl" sha256 -hex)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: sha256 hashing test did not output the expected hash"
    exit 1
fi

output=$("$PACKIT_PACKAGE_PATH/bin/openssl" verify test.pem 2>&1)

if ! echo "$output" | grep -q "verification failed"; then
    echo "Test failed: verifying an invalid certificate did not result in a failed verification"
    exit 1
fi
