#!/bin/sh

set --
if [ "$PACKIT_OS" = "linux" ]; then
    set -- "$@" \
        CPPFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/readline/include -I$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/include" \
        LIBS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/readline/lib -lreadline -L$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/lib -lz"
fi

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules \
    --with-legacy \
    --with-history \
    --with-readline \
    --with-zlib \
    "$@"

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST}" = "1" ] && make check -j $PACKIT_BUILD_JOBS_COUNT

make install

# Replace prefix inside xml2-config script
sed "s|$PACKIT_PACKAGE_PATH|$PACKIT_PREFIX_PATH/active/libxml2|g" "$PACKIT_PACKAGE_PATH/bin/xml2-config" > "$PACKIT_PACKAGE_PATH/bin/xml2-config.patched"
mv "$PACKIT_PACKAGE_PATH/bin/xml2-config.patched" "$PACKIT_PACKAGE_PATH/bin/xml2-config"
