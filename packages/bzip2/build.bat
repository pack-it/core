cd bzip2-%PACKIT_PACKAGE_VERSION%

make -f makefile.msc 

mkdir -p "%PACKIT_PACKAGE_PATH%\bin" 2 > nul 
mkdir -p "%PACKIT_PACKAGE_PATH%\lib" 2 > nul
mkdir -p "%PACKIT_PACKAGE_PATH%\include" 2> nul


copy /Y bzip2.exe "%PACKIT_PACKAGE_PATH%\bin\bzip2.exe"
copy /Y bzip2recover.exe "%PACKIT_PACKAGE_PATH%\bin\bzip2recover.exe"
copy /Y libbz2.lib "%PACKIT_PACKAGE_PATH%\lib\libbz2.lib"
copy /Y bzlib.h "%PACKIT_PACKAGE_PATH%\include\bzlib.h"
