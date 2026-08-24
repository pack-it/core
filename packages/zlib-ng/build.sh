#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --installnamedir="$PACKIT_PACKAGE_PATH/lib"

make -j $PACKIT_BUILD_JOBS_COUNT

# -B is necessary to force testing, otherwise it doesn't test if the source hasn't changed
[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make -B test

make install
