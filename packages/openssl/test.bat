set "test_input=I hashed the previous version of this script, unfortunately the hash was my only backup. Whoops!"

set "expected_output=38517b49c926cb5178a28c388075b9caeca07cc52c398d4419c2fa6f98947c7b"

for /f "delims=" %%A in (`echo %test_input% | "%PACKIT_PACKAGE_PATH%\bin\openssl.exe" sha256 -hex`) do set "output=%%A"
if ERRORLEVEL 1 (
    echo Test failed: openssl command exited with code %ERRORLEVEL%
    exit /b 1
)

if "%output%" != "%expected_output%" (
    echo Test failed: sha256 hashing test did not output the expected hash
    exit /b 1
)

"%PACKIT_PACKAGE_PATH%\bin\openssl.exe" verify test.pem 2>&1 > output.txt
if ERRORLEVEL 1 (
    echo Test failed: openssl command exited with code %ERRORLEVEL%
    exit /b 1
)

findstr /C:"verification failed" output.txt >nul
if errorlevel 1 (
    echo Test failed: verifying an invalid certificate did not result in a failed verification
    exit /b 1
)
