#!/bin/sh

extra_flags=""
if [ "$PACKIT_OS" = "mac" ]; then
    extra_flags="--system-zlib --system-bzip2 --system-curl"
fi

./bootstrap \
    --prefix="$PACKIT_PACKAGE_PATH" \
    --no-system-libs \
    --no-debugger \
    --parallel=$PACKIT_BUILD_JOBS_COUNT \
    $extra_flags

make -j $PACKIT_BUILD_JOBS_COUNT

make install
