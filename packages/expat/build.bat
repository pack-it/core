cmake -S . -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DEXPAT_BUILD_TESTS=ON
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

ctest --verbose -C Release --test-dir build --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
