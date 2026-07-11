if exist "%PACKIT_PREFIX_PATH%/etc/openssl@%PACKIT_PACKAGE_VERSION%/certs/cert.pem" (
    del "%PACKIT_PREFIX_PATH%/etc/openssl@%PACKIT_PACKAGE_VERSION%/certs/cert.pem"
)

mklink "%PACKIT_PREFIX_PATH%/etc/openssl@%PACKIT_PACKAGE_VERSION%/certs/cert.pem" "%PACKIT_PACKAGE_DEPENDENCIES_PATH%/ca-certificates/cert.pem" %PACKIT_OUTPUTS% >&3
