#!/bin/sh

mkdir test
touch test/pass.please

expected_output="test
└── pass.please

1 directory, 1 file"

output=$("$PACKIT_PACKAGE_PATH/bin/tree" test)

if [ "$output" = "$expected_output" ]; then
    exit 0
fi

exit 1
