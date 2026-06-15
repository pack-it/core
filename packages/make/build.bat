cd make-%PACKIT_PACKAGE_VERSION%

call build_w32.bat --without-guile
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

mkdir "%PACKIT_PACKAGE_PATH%\bin\"

copy WinRel\gnumake.exe "%PACKIT_PACKAGE_PATH%\bin\make.exe"
