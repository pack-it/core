#!/bin/sh

test_text="Hello World! Duck, Mouse, Bird, Dog, Horse, idk, that's all the animals I know. I hope it's enough for this test code :)"
echo "$test_text" > test.txt

# Compile test.c
gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" test.c -o test -lz-ng

# Compress the test.txt file
./test < test.txt > compressed

# Decompress the compressed file
./test -d < compressed > decompressed.txt

result=$(cat decompressed.txt)

if [ "$result" = "$test_text" ]; then
    exit 0
fi

exit 1
