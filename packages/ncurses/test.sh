#!/bin/sh

expected_output="$PACKIT_PREFIX_PATH/active/ncurses"
output=$("$PACKIT_PACKAGE_PATH/bin/ncursesw6-config" --prefix)
if [ "$output" != "$expected_output" ]; then
    echo "Test failed: ncursesw6-config --prefix does not return the active package path"
    exit 1
fi

# Compile test.c
gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" test.c -o test -lncurses

# Run test code to see if ncurses works (no text check can be done because ncurses does not write to stdout)
printf 'q' | ./test
