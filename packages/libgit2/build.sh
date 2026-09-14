#!/bin/sh

flags=""
if [ "$PACKIT_OS" = "mac" ]; then
    # The DCMAKE_INSTALL_RPATH is needed because llhttp has an install name containing @rpath
    flags="-DCMAKE_INSTALL_RPATH=\"$PACKIT_PACKAGE_DEPENDENCIES_PATH/llhttp/lib\""
elif [ "$PACKIT_OS" = "linux" ]; then
    flags="-DREGEX_BACKEND=pcre2"
fi

# Put shared flags in the flags
flags="$flags -DBUILD_TESTS=ON"
flags="$flags -DUSE_HTTP_PARSER=llhttp"
flags="$flags -DUSE_SSH=ON"
flags="$flags -DUSE_BUNDLED_ZLIB=OFF"

# Build static library
cmake -S . -B build-static -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF $flags

cmake --build build-static --config Release

# Build tests depend on python, so only execute on macos where python is installed by default
if [ "$PACKIT_OS" = "mac" ] && [ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ]; then
    ctest -C Release --test-dir build-static -E "online|proxy|auth_clone"
fi

cmake --install build-static --config Release

# Build shared libraries
cmake -S . -B build-shared -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON $flags

cmake --build build-shared --config Release

# Build tests depend on python, so only execute on macos where python is installed by default
if [ "$PACKIT_OS" = "mac" ] && [ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ]; then
    ctest -C Release --test-dir build-shared -E "online|proxy|auth_clone"
fi

cmake --install build-shared --config Release
