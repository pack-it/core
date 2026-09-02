REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

nmake /f Mkfiles/msvc.mak prefix="%PACKIT_PACKAGE_PATH%"
if ERRORLEVEL 1 (
    echo NASM build failed
    exit /b %ERRORLEVEL%
)

REM Skip build test, because it requires Perl

mkdir "%PACKIT_PACKAGE_PATH%\bin\"

move ".\nasm.exe" "%PACKIT_PACKAGE_PATH%\bin\"
