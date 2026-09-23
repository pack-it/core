#!/bin/sh

make PREFIX="$PACKIT_PACKAGE_PATH" MANDIR="$PACKIT_PACKAGE_PATH/share/man" -j $PACKIT_BUILD_JOBS_COUNT

# Tree doesn't have a testsuite

make install PREFIX="$PACKIT_PACKAGE_PATH" MANDIR="$PACKIT_PACKAGE_PATH/share/man"
