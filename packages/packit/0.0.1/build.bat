REM Workaround to include Packit in core repository (Packit cannot yet be build, because Rust is not yet a supported package)
mkdir "%PACKIT_PACKAGE_PATH%\bin\"
move "packit@%PACKIT_PACKAGE_VERSION%-0-%PACKIT_TARGET%.exe" "%PACKIT_PACKAGE_PATH%\bin\packit.exe"
mklink "%PACKIT_PACKAGE_PATH%\bin\pit.exe" "%PACKIT_PACKAGE_PATH%\bin\packit.exe"
