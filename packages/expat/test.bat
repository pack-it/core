REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH% %PACKIT_OUTPUTS% >&3

cl /I "%PACKIT_PACKAGE_PATH%\include" test.c /Fe:test.exe /link /LIBPATH:"%PACKIT_PACKAGE_PATH%\lib" libexpat.lib %PACKIT_OUTPUTS% >&3 2>&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

.\test.exe > .\output_file
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

set /p "output="<".\output_file%"
set "expected_output=The count of Numeria says one, two, three, four, five, the thing that comes after five. AAaahhh this happens everytimeee!!"

if not "%output%"=="%expected_output%" (
    echo The test output '%output%' doesn't match the expected output
    exit /b 1
)
