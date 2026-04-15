REM Test relies on GCC, so first check if gcc is installed
where gcc
if ERRORLEVEL 1 (
    echo GCC not installed, skipping test
    exit /b 0
)

REM Create the test.c file (provided by https://zlib.net/zpipe.c^)
(
    echo /* zpipe.c: example of proper use of zlib's inflate^(^) and deflate^(^)
    echo    Not copyrighted -- provided to the public domain
    echo    Version 1.5  11 February 2026  Mark Adler */
    echo /* Version history:
    echo    1.0  30 Oct 2004  First version
    echo    1.1   8 Nov 2004  Add void casting for unused return values
    echo                      Use switch statement for inflate^(^) return values
    echo    1.2   9 Nov 2004  Add assertions to document zlib guarantees
    echo    1.3   6 Apr 2005  Remove incorrect assertion in inf^(^)
    echo    1.4  11 Dec 2005  Add hack to avoid MSDOS end-of-line conversions
    echo                      Avoid some compiler warnings for input and output buffers
    echo    1.5  11 Feb 2026  Use underscores for Windows POSIX names
    echo  */
    echo #include ^<stdio.h^>
    echo #include ^<string.h^>
    echo #include ^<assert.h^>
    echo #include "zlib.h"
    echo #if defined^(MSDOS^) ^|^| defined^(OS2^) ^|^| defined^(WIN32^) ^|^| defined^(__CYGWIN__^)
    echo #  include ^<fcntl.h^>
    echo #  include ^<io.h^>
    echo #  define SET_BINARY_MODE^(file^) _setmode^(_fileno^(file^), _O_BINARY^)
    echo #else
    echo #  define SET_BINARY_MODE^(file^)
    echo #endif
    echo #define CHUNK 16384
    echo /* Compress from file source to file dest until EOF on source.
    echo    def^(^) returns Z_OK on success, Z_MEM_ERROR if memory could not be
    echo    allocated for processing, Z_STREAM_ERROR if an invalid compression
    echo    level is supplied, Z_VERSION_ERROR if the version of zlib.h and the
    echo    version of the library linked do not match, or Z_ERRNO if there is
    echo    an error reading or writing the files. */
    echo int def^(FILE *source, FILE *dest, int level^)
    echo {
    echo     int ret, flush;
    echo     unsigned have;
    echo     z_stream strm;
    echo     unsigned char in[CHUNK];
    echo     unsigned char out[CHUNK];
    echo     /* allocate deflate state */
    echo     strm.zalloc = Z_NULL;
    echo     strm.zfree = Z_NULL;
    echo     strm.opaque = Z_NULL;
    echo     ret = deflateInit^(^&strm, level^);
    echo     if ^(ret != Z_OK^)
    echo         return ret;
    echo     /* compress until end of file */
    echo     do {
    echo         strm.avail_in = fread^(in, 1, CHUNK, source^);
    echo         if ^(ferror^(source^)^) {
    echo             ^(void^)deflateEnd^(^&strm^);
    echo             return Z_ERRNO;
    echo         }
    echo         flush = feof^(source^) ? Z_FINISH : Z_NO_FLUSH;
    echo         strm.next_in = in;
    echo         /* run deflate^(^) on input until output buffer not full, finish
    echo            compression if all of source has been read in */
    echo         do {
    echo             strm.avail_out = CHUNK;
    echo             strm.next_out = out;
    echo             ret = deflate^(^&strm, flush^);    /* no bad return value */
    echo             assert^(ret != Z_STREAM_ERROR^);  /* state not clobbered */
    echo             have = CHUNK - strm.avail_out;
    echo             if ^(fwrite^(out, 1, have, dest^) != have ^|^| ferror^(dest^)^) {
    echo                 ^(void^)deflateEnd^(^&strm^);
    echo                 return Z_ERRNO;
    echo             }
    echo         } while ^(strm.avail_out == 0^);
    echo         assert^(strm.avail_in == 0^);     /* all input will be used */
    echo         /* done when last data in file processed */
    echo     } while ^(flush != Z_FINISH^);
    echo     assert^(ret == Z_STREAM_END^);        /* stream will be complete */
    echo     /* clean up and return */
    echo     ^(void^)deflateEnd^(^&strm^);
    echo     return Z_OK;
    echo }
    echo /* Decompress from file source to file dest until stream ends or EOF.
    echo    inf^(^) returns Z_OK on success, Z_MEM_ERROR if memory could not be
    echo    allocated for processing, Z_DATA_ERROR if the deflate data is
    echo    invalid or incomplete, Z_VERSION_ERROR if the version of zlib.h and
    echo    the version of the library linked do not match, or Z_ERRNO if there
    echo    is an error reading or writing the files. */
    echo int inf^(FILE *source, FILE *dest^)
    echo {
    echo     int ret;
    echo     unsigned have;
    echo     z_stream strm;
    echo     unsigned char in[CHUNK];
    echo     unsigned char out[CHUNK];
    echo     /* allocate inflate state */
    echo     strm.zalloc = Z_NULL;
    echo     strm.zfree = Z_NULL;
    echo     strm.opaque = Z_NULL;
    echo     strm.avail_in = 0;
    echo     strm.next_in = Z_NULL;
    echo     ret = inflateInit^(^&strm^);
    echo     if ^(ret != Z_OK^)
    echo         return ret;
    echo     /* decompress until deflate stream ends or end of file */
    echo     do {
    echo         strm.avail_in = fread^(in, 1, CHUNK, source^);
    echo         if ^(ferror^(source^)^) {
    echo             ^(void^)inflateEnd^(^&strm^);
    echo             return Z_ERRNO;
    echo         }
    echo         if ^(strm.avail_in == 0^)
    echo             break;
    echo         strm.next_in = in;
    echo         /* run inflate^(^) on input until output buffer not full */
    echo         do {
    echo             strm.avail_out = CHUNK;
    echo             strm.next_out = out;
    echo             ret = inflate^(^&strm, Z_NO_FLUSH^);
    echo             assert^(ret != Z_STREAM_ERROR^);  /* state not clobbered */
    echo             switch ^(ret^) {
    echo             case Z_NEED_DICT:
    echo                 ret = Z_DATA_ERROR;     /* and fall through */
    echo             case Z_DATA_ERROR:
    echo             case Z_MEM_ERROR:
    echo                 ^(void^)inflateEnd^(^&strm^);
    echo                 return ret;
    echo             }
    echo             have = CHUNK - strm.avail_out;
    echo             if ^(fwrite^(out, 1, have, dest^) != have ^|^| ferror^(dest^)^) {
    echo                 ^(void^)inflateEnd^(^&strm^);
    echo                 return Z_ERRNO;
    echo             }
    echo         } while ^(strm.avail_out == 0^);
    echo         /* done when inflate^(^) says it's done */
    echo     } while ^(ret != Z_STREAM_END^);
    echo     /* clean up and return */
    echo     ^(void^)inflateEnd^(^&strm^);
    echo     return ret == Z_STREAM_END ? Z_OK : Z_DATA_ERROR;
    echo }
    echo /* report a zlib or i/o error */
    echo void zerr^(int ret^)
    echo {
    echo     fputs^("zpipe: ", stderr^);
    echo     switch ^(ret^) {
    echo     case Z_ERRNO:
    echo         if ^(ferror^(stdin^)^)
    echo             fputs^("error reading stdin\n", stderr^);
    echo         if ^(ferror^(stdout^)^)
    echo             fputs^("error writing stdout\n", stderr^);
    echo         break;
    echo     case Z_STREAM_ERROR:
    echo         fputs^("invalid compression level\n", stderr^);
    echo         break;
    echo     case Z_DATA_ERROR:
    echo         fputs^("invalid or incomplete deflate data\n", stderr^);
    echo         break;
    echo     case Z_MEM_ERROR:
    echo         fputs^("out of memory\n", stderr^);
    echo         break;
    echo     case Z_VERSION_ERROR:
    echo         fputs^("zlib version mismatch!\n", stderr^);
    echo     }
    echo }
    echo /* compress or decompress from stdin to stdout */
    echo int main^(int argc, char **argv^)
    echo {
    echo     int ret;
    echo     /* avoid end-of-line conversions */
    echo     SET_BINARY_MODE^(stdin^);
    echo     SET_BINARY_MODE^(stdout^);
    echo     /* do compression if no arguments */
    echo     if ^(argc == 1^) {
    echo         ret = def^(stdin, stdout, Z_DEFAULT_COMPRESSION^);
    echo         if ^(ret != Z_OK^)
    echo             zerr^(ret^);
    echo         return ret;
    echo     }
    echo     /* do decompression if -d specified */
    echo     else if ^(argc == 2 ^&^& strcmp^(argv[1], "-d"^) == 0^) {
    echo         ret = inf^(stdin, stdout^);
    echo         if ^(ret != Z_OK^)
    echo             zerr^(ret^);
    echo         return ret;
    echo     }
    echo     /* otherwise, report usage */
    echo     else {
    echo         fputs^("zpipe usage: zpipe [-d] ^< source ^> dest\n", stderr^);
    echo         return 1;
    echo     }
    echo }
) > test.c

set TEST_TEXT = "Hello World! Duck, Mouse, Bird, Dog, Horse, idk, that's all the animals I know. I hope it's enough for this test code :)"
echo "%TEST_TEXT%" > test.txt

REM Compile test.c
gcc -L "%PACKIT_PACKAGE_PATH%/lib" -I "%PACKIT_PACKAGE_PATH%/include" test.c -o test -lz

REM Compress the test.txt file
test.exe < test.txt > compressed

REM Decompress the compressed file
test.exe -d < compressed > decompressed.txt

set /p RESULT = < decompressed.txt

if "%RESULT%" == "%TEST_TEXT%" (
    exit /b 0
)

exit /b 1