#!/bin/sh

echo "File with a lot of secret attributes (very secure)" > secret.txt

"$PACKIT_PACKAGE_PATH/bin/attr" -s secret_value -V "nobody can read this" secret.txt >&3

expected_output="nobody can read this"
output=$("$PACKIT_PACKAGE_PATH/bin/attr" -q -g secret_value secret.txt)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi
