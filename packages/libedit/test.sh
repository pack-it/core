#!/bin/sh

# Compile test.c
gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib" test.c -o test -ledit

test_input="Edit edit edit leave a good review on Reddit!"
expected_output="packit> $test_input"

/home/m/Documents/binspect/target/debug/binspect ./test

output=$(echo "$test_input
" | ./test)

if [ "$output" != "$expected_output" ]; then
    exit 1
fi

cat << EOF > readline_test.c
#include <stdio.h>
#include <stdlib.h>
#include <readline/readline.h>

int main() {
    char *line = readline("packit> ");
    printf("%s\n", line);
    return 0;
}
EOF

# Compile readline_test.c
gcc -L "$PACKIT_PACKAGE_PATH/libexec/lib" -I "$PACKIT_PACKAGE_PATH/libexec/include" -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib" readline_test.c -o readline_test -lreadline

test_input="Please don't read this line"
expected_output="$test_input"

output=$(echo "$test_input" | ./readline_test)

if [ "$output" != "$expected_output" ]; then
    exit 1
fi
