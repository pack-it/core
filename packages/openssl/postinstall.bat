REM Copy the openssldir to the destination
if not exist "%PACKIT_PREFIX_PATH%\etc\openssl@%PACKIT_PACKAGE_VERSION%" (
    mkdir "%PACKIT_PREFIX_PATH%\etc\openssl@%PACKIT_PACKAGE_VERSION%"
    xcopy "%PACKIT_PACKAGE_PATH%\.external\etc\openssl@%PACKIT_PACKAGE_VERSION%\*" "%PACKIT_PREFIX_PATH%\etc\openssl@%PACKIT_PACKAGE_VERSION%\" /E /I
)

REM Remove any existing ca-certificates symlink
if exist "%PACKIT_PREFIX_PATH%\etc\openssl@%PACKIT_PACKAGE_VERSION%\certs\cert.pem" (
    del "%PACKIT_PREFIX_PATH%\etc\openssl@%PACKIT_PACKAGE_VERSION%\certs\cert.pem"
)

REM Create ca-certificates symlink
mklink "%PACKIT_PREFIX_PATH%\etc\openssl@%PACKIT_PACKAGE_VERSION%\certs\cert.pem" "%PACKIT_PACKAGE_DEPENDENCIES_PATH%\ca-certificates\cert.pem" %PACKIT_OUTPUTS% >&3
