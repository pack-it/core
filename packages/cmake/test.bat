if not exist "%PACKIT_PACKAGE_PATH%\bin\cmake.exe" (
    echo Test failed: cmake.exe not found
    exit /b 1
)

if not exist "%PACKIT_PACKAGE_PATH%\bin\ctest.exe" (
    echo Test failed: ctest.exe not found
    exit /b 1
)

if not exist "%PACKIT_PACKAGE_PATH%\bin\cpack.exe" (
    echo Test failed: cpack.exe not found
    exit /b 1
)

"%PACKIT_PACKAGE_PATH%\bin\cmake.exe" --version %PACKIT_OUTPUTS% >&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

"%PACKIT_PACKAGE_PATH%\bin\ctest.exe" --version %PACKIT_OUTPUTS% >&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

"%PACKIT_PACKAGE_PATH%\bin\cpack.exe" --version %PACKIT_OUTPUTS% >&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

echo cmake_minimum_required(VERSION 3.10) > CMakeLists.txt
echo project(TestCMake C) >> CMakeLists.txt

mkdir build
cd build
"%PACKIT_PACKAGE_PATH%\bin\cmake.exe" .. %PACKIT_OUTPUTS% >&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
