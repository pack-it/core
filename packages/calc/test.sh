#!/bin/sh

expected_output="20988"
output=$("$PACKIT_PACKAGE_PATH/bin/calc" -p "(112 + 97 + 99 + 107 + 105 + 116) * 33")

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi
