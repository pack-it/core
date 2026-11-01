#!/bin/sh

expected_output="Please don't put me through a pipe"
output=$(echo "Please don't put me through a pipe" | "$PACKIT_PACKAGE_PATH/bin/pv" 2>/dev/null)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi

expected_output="100"
output=$(echo "Please don't put me through a pipe" | "$PACKIT_PACKAGE_PATH/bin/pv" -ns 35 2>&1 >/dev/null)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi
