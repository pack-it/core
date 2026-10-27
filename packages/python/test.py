# Try importing important or dependency libraries
import _sqlite3
import sqlite3
import xml
import _pydecimal # Python implementation
import _decimal # C implementation
import decimal # Chooses which implementation of decimal to use
import _ctypes # _ctypes needs libffi, so this tests the libffi (system) dependency
import pyexpat
import readline
import zlib
import _ssl
import _zstd
import lzma
import sys
import sysconfig
import bz2
import curses

# TODO: Test that tkinter and dbm are NOT installed
