#!/bin/sh

# The shared and the static library are both built in a single configuration
cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_STATIC_LIBS=ON \
    -DBUILD_APPS=ON \
    -DBUILD_TESTING=ON

cmake --build build --config Release

# Replace echo with printf, because echo can use its arguments literally
if [ "$PACKIT_OS" = "mac" ]; then
    sed -i '' '13d' tests/test_json_parse_cli.test
    sed -i '' "13i\\
printf \'%s\' \'\"tenant=blue\;note=CANARY_STACK_WINDOW_2026\;status=ok\"\' > file1.dat
" tests/test_json_parse_cli.test
elif [ "$PACKIT_OS" = "linux" ]; then
    sed -i '13d' tests/test_json_parse_cli.test
    sed -i "13i\\
printf \'%s\' \'\"tenant=blue\;note=CANARY_STACK_WINDOW_2026\;status=ok\"\' > file1.dat
" tests/test_json_parse_cli.test
fi
ctest --verbose -C Release --test-dir build

cmake --install build --config Release
