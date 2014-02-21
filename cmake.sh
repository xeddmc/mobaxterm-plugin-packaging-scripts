#!/bin/sh

#Stop on error.
set -e

#Output name.
PKG_NAME=CMake

#Sources and dependency names.
ZIP=zip-3.0-11
CMAKE=cmake-2.8.9-2
CMAKE_VER=cmake-2.8.9
LIDN=libidn11-1.26-1
LNCURSES=libncurses10-5.7-18
LSTDCPP=libstdc++6-4.8.2-2

#Clean up.
rm -rf .working_dir
mkdir .working_dir
cd .working_dir

#Grab sources and dependencies.
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/zip/$ZIP.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/cmake/$CMAKE.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/libidn/libidn11/$LIDN.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/ncurses/libncurses10/$LNCURSES.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/gcc/libstdc++6/$LSTDCPP.tar.xz

#Unzip.
tar xjf $ZIP.tar.bz2 -C / #Needed for packaging.
tar xjf $CMAKE.tar.bz2
tar xjf $LIDN.tar.bz2
tar xjf $LNCURSES.tar.bz2
tar xf $LSTDCPP.tar.xz

#Move sources in place for packaging.
## Bin directory.
mkdir $PKG_NAME
mkdir $PKG_NAME/bin
cp -r usr/bin/* $PKG_NAME/bin
## Lib directory.
###mkdir $PKG_NAME/lib
###cp -r usr/lib/* $PKG_NAME/lib
## Include and Share directory.
mkdir $PKG_NAME/usr
###cp -r usr/include $PKG_NAME/usr
cp -r usr/share $PKG_NAME/usr
#Copy modules and templates into bin for CMake to work correctly.
cp -r usr/share/$CMAKE_VER/Modules $PKG_NAME/bin
cp -r usr/share/$CMAKE_VER/Templates $PKG_NAME/bin

#Build package.
cd $PKG_NAME
zip -r $PKG_NAME.mxt3 .
mv $PKG_NAME.mxt3 ../../
echo "Created package $PKG_NAME.mxt3 successfully!" 
