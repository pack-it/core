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
echo Found vcvarsall.bat at %VCVARSALL% %PACKIT_OUTPUTS% >&3

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
call "%VCVARSALL%" %ARCH% %PACKIT_OUTPUTS% >&3

cl /I "%PACKIT_PACKAGE_PATH%\include" test.c /Fe:test.exe /link /LIBPATH:"%PACKIT_PACKAGE_PATH%\lib" libpng.lib "%PACKIT_PACKAGE_DEPENDENCIES_PATH%\zlib-ng-compat\lib\zlib.lib" %PACKIT_OUTPUTS% >&3 2>&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

.\test.exe
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
