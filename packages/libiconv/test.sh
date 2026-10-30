#!/bin/sh

expected_output="Arrrrr! Greetings from Pirate LE, sailing the UTF-16 sees"
output=$("$PACKIT_PACKAGE_PATH/bin/iconv" -f UTF-16LE -t UTF-8 test.txt)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi

gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" test.c -o test -liconv

output=$("./test")

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi
