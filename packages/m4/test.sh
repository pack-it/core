#!/bin/sh

expected_output="Hello, Linus! 72"
output=$("$PACKIT_PACKAGE_PATH/bin/m4" <<"EOF"
define(`PERSON', `Linus')dnl
define(`greet', `Hello, $1!')dnl
define(`square', `eval(($1) * ($2))')dnl
greet(PERSON) square(12, 6)
EOF
)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi
