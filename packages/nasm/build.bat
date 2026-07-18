cd nasm-%PACKIT_PACKAGE_VERSION%

REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

nmake /f Mkfiles/msvc.mak prefix="%PACKIT_PACKAGE_PATH%"
if ERRORLEVEL 1 (
    echo NASM build failed
    exit /b %ERRORLEVEL%
)

mkdir "%PACKIT_PACKAGE_PATH%\bin\"

move ".\nasm.exe" "%PACKIT_PACKAGE_PATH%\bin\"
