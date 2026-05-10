#!/bin/sh

test_text="It's Sunday 10 of May 2026 and it's a beautiful summer day!"
echo "$test_text" > test.txt

# Compress and decompress to see if information stays the same
lz4 test.txt compressed.lz4
lz4 -d compressed.lz4 decompressed.txt

result=$(cat decompressed.txt)

if [ "$result" = "$test_text" ]; then
    exit 0
fi

exit 1
