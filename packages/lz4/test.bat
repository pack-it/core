set TEST_TEXT = "It's Sunday 10 of May 2026 and it's a beautiful summer day!"
echo "%TEST_TEXT%" > test.txt

REM Compress and decompress to see if information stays the same
lz4 test.txt compressed.lz4
lz4 -d compressed.lz4 decompressed.txt

set /p RESULT = < decompressed.txt

if "%RESULT%" == "%TEST_TEXT%" (
    exit /b 0
)

exit /b 1
