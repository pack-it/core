if not exist "%PACKIT_PACKAGE_PATH%/cacert.pem" (
    echo Test failed: cacert.pem file cannot be found
    exit /b 1
)

if not exist "%PACKIT_PACKAGE_PATH%/cert.pem" (
    echo Test failed: cert.pem file cannot be found
    exit /b 1
)
