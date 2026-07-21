cd libpng-%PACKIT_PACKAGE_VERSION%

REM Read Visual Studio install path
for /f "tokens=* usebackq" %%i in (`"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do (
    set VSPATH=%%i
)
if not exist "%VSPATH%" (
    echo Visual Studio cannot be loaded from %VSPATH%
    exit /b 1
)

REM Check if vcvarsall.bat exists
set "VCVARSALL=%VSPATH%\VC\Auxiliary\Build\vcvarsall.bat"
if not exist "%VCVARSALL%" (
    echo vcvarsall.bat cannot be loaded from %VCVARSALL%
    exit /b 1
)
echo Found vcvarsall.bat at %VCVARSALL%

REM Retrieve architecture from target
if "%PACKIT_TARGET%"=="x86_64-pc-windows-msvc" (
    set ARCH=x64
) else if "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    set ARCH=arm64
) else (
    echo Target %PACKIT_TARGET% is not supported for this package
    exit /b 1
)

REM Call vcvarsall.bat to set MSVC build environment
call "%VCVARSALL%" %ARCH%

if "%PACKIT_TARGET%" == "x86_64-pc-windows-msvc" (
    nmake -f scripts\makefile.vcwin32 CFLAGS="/I\"%PACKIT_PACKAGE_DEPENDENCIES_PATH%\zlib\include\""
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
