REM Call vcvarsall.bat to initialize MSVC build environment (the automatic detection does not always work reliably)
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH% %PACKIT_OUTPUTS% >&3

call build_w32.bat --without-guile
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM Skipping build tests, because they require Perl

mkdir "%PACKIT_PACKAGE_PATH%\bin\"

copy WinRel\gnumake.exe "%PACKIT_PACKAGE_PATH%\bin\make.exe"
