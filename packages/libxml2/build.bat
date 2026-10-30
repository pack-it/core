REM Build static library
cmake -S . -B build-static -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DLIBXML2_WITH_ZLIB=ON -DLIBXML2_WITH_ICONV=OFF
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build-static --config Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

if "%PACKIT_EXECUTE_BUILD_TEST%"=="1" ctest -C Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build-static --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM Build shared libraries
cmake -S . -B build-shared -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DLIBXML2_WITH_ZLIB=ON -DLIBXML2_WITH_ICONV=OFF
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build-shared --config Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

if "%PACKIT_EXECUTE_BUILD_TEST%"=="1" ctest -C Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build-shared --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
