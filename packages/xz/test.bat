set TEST_TEXT = "CMake is finally added as package, so we can add xz!"
echo "%TEST_TEXT%" > test.txt

REM Compress and decompress to see if information stays the same
"%PACKIT_PACKAGE_PATH%\bin\xz" -c test.txt > compressed.xz
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
"%PACKIT_PACKAGE_PATH%\bin\xz" -dc compressed.xz > decompressed.txt
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

set /p RESULT = < decompressed.txt

if not "%RESULT%" == "%TEST_TEXT%" (
    echo Test failed: test result '%RESULT%' does not match the expected result
    exit /b 1
)
