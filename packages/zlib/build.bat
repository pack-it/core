cd zlib-%PACKIT_PACKAGE_VERSION%

nmake -f win32/Makefile.msc

if not exist zlib.h (
    exit \b 1
)

if not exist zconf.h (
    exit \b 1
)

if not exist zlib.lib (
    exit \b 1
)

if not exist zdll.lib (
    exit \b 1
)

mkdir "%PACKIT_PACKAGES_PATH%\include"
mkdir "%PACKIT_PACKAGES_PATH%\lib\pkgconfig"
mkdir "%PACKIT_PACKAGES_PATH%\bin"

move "zlib1.dll" "%PACKIT_PACKAGES_PATH%\bin"
move "zdll.lib" "%PACKIT_PACKAGES_PATH%\lib"
move "zlib.h" "%PACKIT_PACKAGES_PATH%\include"
move "zconf.h" "%PACKIT_PACKAGES_PATH%\include"
move "zlib.lib" "%PACKIT_PACKAGES_PATH%\lib"
