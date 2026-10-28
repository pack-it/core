#!/bin/sh

test_text="Stress stress stress let's hope this doesn't crash!"
echo "$test_text" > test.txt

# Compress and decompress to see if information stays the same
"$PACKIT_PACKAGE_PATH/bin/brotli" test.txt --output=compressed.txt.br
"$PACKIT_PACKAGE_PATH/bin/brotli" compressed.txt.br --output=decompressed.txt --decompress

result=$(cat decompressed.txt)

if [ "$result" != "$test_text" ]; then
    echo "Test failed: test result '$result' does not match the expected result"
    exit 1
fi
