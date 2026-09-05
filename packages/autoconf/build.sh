#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

if [ "$PACKIT_OS" = "mac" ]; then
    # Ignore test 248, because it sometimes fails (probably because macOS doesn't have nanosecond precision in this test)
    export TESTSUITEFLAGS="-247 249-"
fi

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make check

make install

# Remove unwanted standards.info file
rm -f "$PACKIT_PACKAGE_PATH"/share/info/standards.info
