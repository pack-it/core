#!/bin/sh

test_text="Test test test I guess none of the many compression libraries is the best :)"
echo "$test_text" > test.txt

# Compress and decompress to see if information stays the same
$PACKIT_PACKAGE_PATH/bin/zstd -c test.txt > compressed.zst
$PACKIT_PACKAGE_PATH/bin/zstd -cd compressed.zst > decompressed.txt

result=$(cat decompressed.txt)

if [ "$result" = "$test_text" ]; then
    exit 0
fi

exit 1
