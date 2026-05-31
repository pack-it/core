cd lz4-%PACKIT_PACKAGE_VERSION%

cmake -S "build/cmake" -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%"

cmake --build build --config Release

ctest --verbose -C Release

cmake --install build
