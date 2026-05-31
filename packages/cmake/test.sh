#!/bin/sh

if [ ! -e "$PACKIT_PACKAGE_PATH/bin/cmake" ]; then
    echo "Test failed: cmake not found"
    exit 1
fi

if [ ! -e "$PACKIT_PACKAGE_PATH/bin/ctest" ]; then
    echo "Test failed: ctest not found"
    exit 1
fi

if [ ! -e "$PACKIT_PACKAGE_PATH/bin/cpack" ]; then
    echo "Test failed: cpack not found"
    exit 1
fi

"$PACKIT_PACKAGE_PATH/bin/cmake" --version
"$PACKIT_PACKAGE_PATH/bin/ctest" --version
"$PACKIT_PACKAGE_PATH/bin/cpack" --version

cat << EOF > CMakeLists.txt
cmake_minimum_required(VERSION 3.10)
project(TestCMake C)
EOF

mkdir build
cd build
"$PACKIT_PACKAGE_PATH/bin/cmake" ..
