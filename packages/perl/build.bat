cd perl-%PACKIT_PACKAGE_VERSION%

cd win32

REM Convert MSVC version for make variable
set "MSVCMAJOR=%PACKIT_MSVC_VERSION:~0,2%"
set "MSVCMINOR=%PACKIT_MSVC_VERSION:~3,1%"
set "MSVCNAME=MSVC%MSVCMAJOR%%MSVCMINOR%"
echo Found MSCV name %MSVCNAME%

REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

REM Patch Makefile to include quotes in install path
powershell -NoProfile -Command ^
"$file='Makefile'; ^
$text = Get-Content -Raw $file; ^
$text = $text -replace [regex]::Escape('$(INST_BIN)\*.*'), '\"$(INST_BIN)\*.*\"'; ^
$text = $text -replace [regex]::Escape('$(INST_SCRIPT)\*.*'), '\"$(INST_SCRIPT)\*.*\"'; ^
$text = $text -replace [regex]::Escape('$(INST_HTML)\*.*'), '\"$(INST_HTML)\*.*\"'; ^
Set-Content -NoNewline -Encoding UTF8 $file $text"

set "DRIVE=%PACKIT_PACKAGE_PATH:~0,2%"
echo Setting drive to %DRIVE%

REM Build Perl
nmake INST_DRV="%DRIVE%" INST_TOP="%PACKIT_PACKAGE_PATH%" CCTYPE="%MSVCNAME%"
if ERRORLEVEL 1 (
    echo Perl build failed
    exit /b %ERRORLEVEL%
)

nmake test-notty INST_DRV="%DRIVE%" INST_TOP="%PACKIT_PACKAGE_PATH%" CCTYPE="%MSVCNAME%"
if ERRORLEVEL 1 (
    echo Perl tests failed
    exit /b %ERRORLEVEL%
)

nmake install INST_DRV="%DRIVE%" INST_TOP="%PACKIT_PACKAGE_PATH%" CCTYPE="%MSVCNAME%"
if ERRORLEVEL 1 (
    echo Perl install failed
    exit /b %ERRORLEVEL%
)
