cd lz4-%PACKIT_PACKAGE_VERSION%

cmake -S "build/cmake" -B build

cmake --build build --config Release

cmake --install build --prefix "%PACKIT_PACKAGE_PATH%"
