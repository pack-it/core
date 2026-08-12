#!/bin/sh

test_text="Long live Packit!"
echo "$test_text" > test.txt

# Compress and decompress to see if information stays the same
$PACKIT_PACKAGE_PATH/bin/bzip2 -c test.txt > compressed.bz2
$PACKIT_PACKAGE_PATH/bin/bzip2 -d compressed.bz2 > decompressed.txt

result=$(cat decompressed.txt)

if [ "$result" != "$test_text" ]; then
    echo "Test failed: test result '$result' does not match the expected result"
    exit 1
fi
