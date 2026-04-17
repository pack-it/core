if not exist "%PACKIT_PACKAGE_PATH%\bin\cmake.exe" (
    echo ERROR: cmake.exe not found
    exit /b 1
)

if not exist "%PACKIT_PACKAGE_PATH%\bin\ctest.exe" (
    echo ERROR: ctest.exe not found
    exit /b 1
)

if not exist "%PACKIT_PACKAGE_PATH%\bin\cpack.exe" (
    echo ERROR: cpack.exe not found
    exit /b 1
)

"%PACKIT_PACKAGE_PATH%\bin\cmake.exe" --version
if ERRORLEVEL 1 exit /b 1

"%PACKIT_PACKAGE_PATH%\bin\ctest.exe" --version
if ERRORLEVEL 1 exit /b 1

"%PACKIT_PACKAGE_PATH%\bin\cpack.exe" --version
if ERRORLEVEL 1 exit /b 1

echo cmake_minimum_required(VERSION 3.10) > CMakeLists.txt
echo project(TestCMake C) >> CMakeLists.txt

mkdir build 2>nul

cd build
"%PACKIT_PACKAGE_PATH%\bin\cmake.exe" ..
if ERRORLEVEL 1 exit /b 1

echo CMake test passed
exit /b 0