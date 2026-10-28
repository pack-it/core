REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH% %PACKIT_OUTPUTS% >&3

(
    echo int main(int argc, char **argv^) { return 0; }
) > test.c
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

(
    echo rule compile
    echo    command = cl /c $in /Fo:$out
    echo rule link
    echo    command = cl $in /Fe:$out
    echo build test.obj: compile test.c
    echo build test.exe: link test.obj
    echo default test.exe
) > build.ninja
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

"%PACKIT_PACKAGE_PATH%\bin\ninja" %PACKIT_OUTPUTS% >&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

.\test.exe
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
