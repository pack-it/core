#!/bin/sh

extra_flags=""
if [ "$PACKIT_OS" = "mac" ]; then
    extra_flags="--system-zlib --system-bzip2 --system-curl"
fi

./bootstrap \
    --prefix="$PACKIT_PACKAGE_PATH" \
    --no-system-libs \
    --no-debugger \
    $extra_flags

make

# Skip `RunCMake.Framework`, `RunCMake.XcFramework` and `Framework`, because they require the iOS SDK, which are not always present.
# Skip `RunCMake.CMakePackage`, because it tries to build for an i386 architecture which is deprecated on macOS.
[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && ./bin/ctest -C Release -E "RunCMake.Framework|RunCMake.XcFramework|Framework|RunCMake.CMakePackage"

make install
