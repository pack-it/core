cd json-c-%PACKIT_PACKAGE_VERSION%

REM The shared and the static library are both built in a single configuration
cmake -S . -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=ON -DBUILD_APPS=OFF -DBUILD_TESTING=ON
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

ctest --verbose -C Release --test-dir build
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
