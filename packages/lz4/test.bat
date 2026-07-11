set TEST_TEXT = "It's Sunday 10 of May 2026 and it's a beautiful summer day!"
echo "%TEST_TEXT%" > test.txt

REM Compress and decompress to see if information stays the same
"%PACKIT_PACKAGE_PATH%\bin\lz4" test.txt compressed.lz4 %PACKIT_OUTPUTS% 2>&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

"%PACKIT_PACKAGE_PATH%\bin\lz4" -d compressed.lz4 decompressed.txt %PACKIT_OUTPUTS% 2>&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

set /p RESULT = < decompressed.txt

if "%RESULT%" == "%TEST_TEXT%" (
    exit /b 0
)

exit /b 1
