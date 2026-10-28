set TEST_TEXT = "Stress stress stress let's hope this doesn't crash!"
echo "%TEST_TEXT%" > test.txt

REM Compress and decompress to see if information stays the same
"%PACKIT_PACKAGE_PATH%\bin\brotli" test.txt --output=compressed.txt.br
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
"%PACKIT_PACKAGE_PATH%\bin\brotli" compressed.txt.br --output=decompressed.txt --decompress
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

set /p RESULT = < decompressed.txt

if not "%RESULT%" == "%TEST_TEXT%" (
    echo Test failed: test result '%RESULT%' does not match the expected result
    exit /b 1
)
