#!/bin/sh

cat << EOF > test.c
#include <stdio.h>
#include <stdlib.h>
#include <readline/readline.h>

int main() {
    char *line = readline("packit> ");
    printf("%s\n", line);
    return 0;
}
EOF

# Compile test.c
gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" test.c -o test -lreadline

test_input="Please don't read this line"
expected_output="packit> $test_input
$test_input"

output=$(echo "$test_input
" | ./test)

if [ "$output" = "$expected_output" ]; then
    exit 0
fi

exit 1
