REM Build static
cmake -S . -B build-static -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build-static --config Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

if "%PACKIT_EXECUTE_BUILD_TEST%"=="1" ctest -C Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build-static --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM Build shared
cmake -S . -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

if "%PACKIT_EXECUTE_BUILD_TEST%"=="1" ctest -C Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
