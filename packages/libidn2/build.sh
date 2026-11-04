#!/bin/sh

extra_flags=""
if [ "$PACKIT_OS" = "mac" ]; then
    extra_flags="--with-libintl-prefix=$PACKIT_PACKAGE_DEPENDENCIES_PATH/gettext"
fi

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules \
    --with-libunistring-prefix=$PACKIT_PACKAGE_DEPENDENCIES_PATH/libunistring \
    --with-packager="Packit" \
    $extra_flags

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST}" = "1" ] && make check -j $PACKIT_BUILD_JOBS_COUNT

make install

# Remove unwanted html docs
rm -r "$PACKIT_PACKAGE_PATH/share/gtk-doc"
