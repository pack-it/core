#!/bin/sh

make -j $PACKIT_BUILD_JOBS_COUNT PREFIX=$PACKIT_PACKAGE_PATH

# Also executes some unnecessary speed tests
[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make test -j $PACKIT_BUILD_JOBS_COUNT

make install PREFIX=$PACKIT_PACKAGE_PATH
