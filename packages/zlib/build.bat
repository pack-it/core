REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

nmake -f win32/Makefile.msc
if ERRORLEVEL 1 (
    echo Building zlib failed
    exit /b 1
)

if not exist zlib.h (
    echo zlib.h was not built succesfully
    exit /b 1
)

if not exist zconf.h (
    echo zconf.h was not built succesfully
    exit /b 1
)

if not exist zlib.lib (
    echo zlib.lib was not built succesfully
    exit /b 1
)

if not exist zdll.lib (
    echo zdll.lib was not built succesfully
    exit /b 1
)

if "%PACKIT_EXECUTE_BUILD_TEST%"=="1" nmake -f win32/Makefile.msc test

mkdir "%PACKIT_PACKAGE_PATH%\include\"
mkdir "%PACKIT_PACKAGE_PATH%\lib\"
mkdir "%PACKIT_PACKAGE_PATH%\bin\"

move "zlib1.dll" "%PACKIT_PACKAGE_PATH%\bin\"
move "zdll.lib" "%PACKIT_PACKAGE_PATH%\lib\"
move "zlib.h" "%PACKIT_PACKAGE_PATH%\include\"
move "zconf.h" "%PACKIT_PACKAGE_PATH%\include\"
move "zlib.lib" "%PACKIT_PACKAGE_PATH%\lib\"
