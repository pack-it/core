#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

# Only execute build tests on x86-64 targets and skip on Linux because the test requires Perl.
if [ "$PACKIT_TARGET" == "x86_64-apple-darwin" ] && [ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ]; then
    make golden
    make test
fi

make install
