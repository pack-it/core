#!/bin/sh

test_text="It's Sunday 10 of May 2026 and it's a beautiful summer day!"
echo "$test_text" > test.txt

# Compress and decompress to see if information stays the same
"$PACKIT_PACKAGE_PATH/bin/xz" -c test.txt > compressed.xz
"$PACKIT_PACKAGE_PATH/bin/xz" -dc compressed.xz > decompressed.txt

result=$(cat decompressed.txt)

if [ "$result" = "$test_text" ]; then
    exit 0
fi

exit 1
