#!/bin/sh

# Compile test.c
gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" test.c -o test -lreadline -lncurses

test_input="Edit edit edit leave a good review on Reddit!"
expected_output="packit> $test_input"

output=$(echo "$test_input
" | ./test)

if [ "$output" = "$expected_output" ]; then
    exit 0
fi

exit 1
