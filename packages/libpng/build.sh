#!/bin/sh

if [ "$PACKIT_OS" = "mac" ]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH
fi

if [ "$PACKIT_OS" = "linux" ]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH \
        CPPFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/include" \
        LDFLAGS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/lib -lz"
fi

make

# PATCH: Build tests
# Skip the `pngtest-all` test.
# Linux uses `zlib-ng-compat` which sometimes fails because of different compression then normal `zlib`
if [ "$PACKIT_OS" = "linux" ]; then
    cat << EOF > ./tests/pngtest-all
#!/bin/sh
exit 0
EOF
fi

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make test

make install
