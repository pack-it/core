cd libpng-%PACKIT_PACKAGE_VERSION%

if %PACKIT_TARGET% "x86_64-pc-windows-msvc" (
    nmake -f scripts\makefile.vcwin32
) else if %PACKIT_TARGET% "aarch64-pc-windows-msvc" (
    nmake -f scripts\makefile.vcwin-arm64
) else (
    echo Insupported target, exiting
    exit /b 1
)
