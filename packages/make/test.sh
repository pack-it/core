#!/bin/sh

test_output="Let us make make work"

cat << EOF > Makefile
all:
	@echo $test_output
EOF

make="$PACKIT_PACKAGE_PATH/bin/make"
if [ "$PACKIT_OS" = "mac" ]; then
    make="$PACKIT_PACKAGE_PATH/bin/gmake"
fi

output=$("$make")

if [ "$output" != "$test_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi
