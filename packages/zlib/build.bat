cd zlib-%PACKIT_PACKAGE_VERSION%

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

REM Patch Makefile on ARM64 systems to remove the base option
if "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    powershell -NoProfile -Command "$file='win32/Makefile.msc'; $text=Get-Content -Raw $file; $text=$text -replace [regex]::Escape('-base:0x5A4C0000 '),''; Set-Content -NoNewline -Encoding UTF8 $file $text"
)

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

mkdir "%PACKIT_PACKAGE_PATH%\include\"
mkdir "%PACKIT_PACKAGE_PATH%\lib\"
mkdir "%PACKIT_PACKAGE_PATH%\bin\"

move "zlib1.dll" "%PACKIT_PACKAGE_PATH%\bin\"
move "zdll.lib" "%PACKIT_PACKAGE_PATH%\lib\"
move "zlib.h" "%PACKIT_PACKAGE_PATH%\include\"
move "zconf.h" "%PACKIT_PACKAGE_PATH%\include\"
move "zlib.lib" "%PACKIT_PACKAGE_PATH%\lib\"
