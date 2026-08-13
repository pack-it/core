set TEST_TEXT = "Test test test I guess none of the many compression libraries is the best :)"
echo "%TEST_TEXT%" > test.txt

REM Compress and decompress to see if information stays the same
"%PACKIT_PACKAGE_PATH%\bin\zstd" -c test.txt > compressed.zst
if ERRORLEVEL 1 (
    echo Compression failed
    exit /b 1
)

"%PACKIT_PACKAGE_PATH%\bin\zstd" -dc compressed.zst > decompressed.txt
if ERRORLEVEL 1 (
    echo Decompression failed
    exit /b 1
)

set /p RESULT = < decompressed.txt

if not "%RESULT%" == "%TEST_TEXT%" (
    echo Test failed: test result '%RESULT%' does not match the expected result
    exit /b 1
)
