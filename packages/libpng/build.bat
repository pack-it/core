REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

if "%PACKIT_TARGET%" == "x86_64-pc-windows-msvc" (
    nmake -f scripts\makefile.vcwin32 CFLAGS="/I\"%PACKIT_PACKAGE_DEPENDENCIES_PATH%\zlib-ng-compat\include\""
) else if "%PACKIT_TARGET%" == "aarch64-pc-windows-msvc" (
    nmake -f scripts\makefile.vcwin-arm64
) else (
    echo Target %PACKIT_TARGET% is not supported for this package
    exit /b 1
)

if ERRORLEVEL 1 (
    echo libpng build failed
    exit /b 1
)

REM Skip the build tests, because the path to the `zlib` dependency is hardcoded as `..\zlib\zlib.lib`

REM Installation to include directory
mkdir "%PACKIT_PACKAGE_PATH%\include\libpng16\"
move "png.h" "%PACKIT_PACKAGE_PATH%\include\libpng16\"
move "pngconf.h" "%PACKIT_PACKAGE_PATH%\include\libpng16\"
move "pnglibconf.h" "%PACKIT_PACKAGE_PATH%\include\libpng16\"

mklink "%PACKIT_PACKAGE_PATH%\include\png.h" "%PACKIT_PACKAGE_PATH%\include\libpng16\png.h"
mklink "%PACKIT_PACKAGE_PATH%\include\pngconf.h" "%PACKIT_PACKAGE_PATH%\include\libpng16\pngconf.h"
mklink "%PACKIT_PACKAGE_PATH%\include\pnglibconf.h" "%PACKIT_PACKAGE_PATH%\include\libpng16\pnglibconf.h"

REM Installation to lib directory
mkdir "%PACKIT_PACKAGE_PATH%\lib\"
move "libpng.lib" "%PACKIT_PACKAGE_PATH%\lib\"
