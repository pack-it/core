REM Go up one level if we are in the `bin` directory and see the `pit` file
if exist "pit" (
    cd ..
)

REM Go up one level if we are in the build directory and see the `bin` directory
if exist "bin" (
    cd ..
)

mkdir "%PACKIT_PACKAGE_PATH%"
xcopy ".\packit@%PACKIT_PACKAGE_VERSION%-0-%PACKIT_TARGET%\*" "%PACKIT_PACKAGE_PATH%\" /E /I
