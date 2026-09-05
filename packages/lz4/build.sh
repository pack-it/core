#!/bin/sh

make PREFIX=$PACKIT_PACKAGE_PATH

# Also executes some unnecessary speed tests
[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make test

make install PREFIX=$PACKIT_PACKAGE_PATH
