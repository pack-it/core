cd lua-%PACKIT_PACKAGE_VERSION%

REM Read Visual Studio install path
for /f "tokens=* usebackq" %%i in (`"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do (
    set "VSPATH=%%i"
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
    set "ARCH=x64"
) else if "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    set "ARCH=arm64"
) else (
    echo Target %PACKIT_TARGET% is not supported for this package
    exit /b 1
)

REM Set MSVC build environment
call "%VCVARSALL%" %ARCH%
if ERRORLEVEL 1 (
    echo Failed to initialize Visual Studio build environment
    exit /b %ERRORLEVEL%
)

REM Build Lua
make
if ERRORLEVEL 1 (
    echo Lua build failed
    exit /b %ERRORLEVEL%
)

REM Install binaries
robocopy src "%PACKIT_PACKAGE_PATH%\bin" lua.exe lua.exe
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%

robocopy src "%PACKIT_PACKAGE_PATH%\bin" luac.exe luac.exe
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%

REM Install headers
robocopy src "%PACKIT_PACKAGE_PATH%\include" lua.h lualib.h lauxlib.h luaconf.h
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%

REM Install library
robocopy src "%PACKIT_PACKAGE_PATH%\lib" lua.lib
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%

exit /b 0