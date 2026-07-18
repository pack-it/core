cd zlib-%PACKIT_PACKAGE_VERSION%

REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

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
