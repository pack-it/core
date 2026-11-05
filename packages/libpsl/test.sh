#!/bin/sh

expected_output="nl: 1"
output=$("$PACKIT_PACKAGE_PATH/bin/psl" --no-star-rule nl)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi

expected_output="does-not-exist: 0"
output=$("$PACKIT_PACKAGE_PATH/bin/psl" --no-star-rule does-not-exist)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi

gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib" test.c -o test -lpsl

./test
