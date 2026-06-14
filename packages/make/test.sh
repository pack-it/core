#!/bin/sh

test_output="Let's make make work"

cat << EOF > Makefile
all:
	@echo $test_output
EOF

output=$("$PACKIT_PACKAGE_PATH/bin/make")

if [ "$output" = "$test_output" ]; then
    exit 0
fi

exit 1
