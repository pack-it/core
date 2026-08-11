#!/bin/sh
cd json-c-$PACKIT_PACKAGE_VERSION

get_answer() {
    if [ -t 0 ]; then
        read answer
    else
        read answer < /dev/tty
    fi

    echo "$answer"
}

# The shared and the static library are both built in a single configuration
cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_STATIC_LIBS=ON \
    -DBUILD_APPS=ON \
    -DBUILD_TESTING=ON

cmake --build build --config Release

#build/apps/json_parse -u -N -n -
find . -name "file1.dat" -type f
find . -name "file2.dat" -type f
echo "HERE"

pwd
get_answer

#( cat file1.dat ; cat file2.dat ) | run_output_test -o "test1" --exit 1 ../apps/json_parse -u -N -n -
(ctest --test-dir build --output-on-failure -V -R test_json_parse_cli)
cat `find build/tests -name '*test_json_parse_cli*.out' -ls`


ctest --verbose -C Release --test-dir build

cmake --install build --config Release
