#!/bin/sh

expected_output="xn--pkt-ulak7b"
output=$("$PACKIT_PACKAGE_PATH/bin/idn2" påçkît)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi

gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib" test.c -o test -lidn2

./test
