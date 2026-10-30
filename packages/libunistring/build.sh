#!/bin/sh

# Only give libiconv prefix to configure if it is a dependency
extra_flags=""
if [ -d "$PACKIT_PACKAGE_DEPENDENCIES_PATH/libiconv" ]; then
    extra_flags="--with-libiconv-prefix=$PACKIT_PACKAGE_DEPENDENCIES_PATH/libiconv"
fi

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules $extra_flags

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST}" = "1" ] && make check -j $PACKIT_BUILD_JOBS_COUNT

make install
