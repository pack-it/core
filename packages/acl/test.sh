#!/bin/sh

echo "File with very complicated permissions" > perms.txt
chmod 664 perms.txt

expected_output="user::rw-
group::rw-
other::r--"
output=$("$PACKIT_PACKAGE_PATH/bin/getfacl" -c perms.txt)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output does not match the expected output:"
    echo "$output"
    exit 1
fi

"$PACKIT_PACKAGE_PATH/bin/setfacl" --modify u:$USER:x perms.txt

expected_output="user::rw-
user:$USER:--x
group::rw-
mask::rwx
other::r--"
output=$("$PACKIT_PACKAGE_PATH/bin/getfacl" -c perms.txt)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output does not match the expected output:"
    echo "$output"
    exit 1
fi

gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" test.c -o test -lacl

# Expected output is the same as previous test case
output=$("./test")

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test output does not match the expected output:"
    echo "$output"
    exit 1
fi
