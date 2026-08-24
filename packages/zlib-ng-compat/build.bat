cmake -S . -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DZLIB_COMPAT=ON
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

ctest --verbose -C Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
