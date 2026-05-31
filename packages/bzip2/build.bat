cd bzip2-%PACKIT_PACKAGE_VERSION%

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

nmake -f makefile.msc 
if ERRORLEVEL 1 (
    echo Bzip2 build failed
    exit /b %ERRORLEVEL%
)

robocopy . "%PACKIT_PACKAGE_PATH%\bin" bzip2.exe
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%
robocopy . "%PACKIT_PACKAGE_PATH%\bin" bzip2recover.exe
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%
robocopy . "%PACKIT_PACKAGE_PATH%\lib" libbz2.lib
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%
robocopy . "%PACKIT_PACKAGE_PATH%\include" bzlib.h
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%

dir

exit /b 0
