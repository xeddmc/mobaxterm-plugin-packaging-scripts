#!/bin/sh

#Stop on error.
set -e

#Output name.
PKG_NAME=CGDB

#Sources and dependency names.
ZIP=zip-3.0-11
CGDB=cgdb-0.6.7
LNCURSES=libncurses9-5.7-16
LNCURSES_BIN=cygncurses-9.dll
READLINE=libreadline7-6.1.2-3
READLINE_DEV=readline-6.1.2-3
READLINE_BIN=cygreadline7.dll

#Clean up.
rm -rf .working_dir
mkdir .working_dir
cd .working_dir

#Grab sources and dependencies.
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/zip/$ZIP.tar.bz2
wget http://cgdb.me/files/$CGDB.tar.gz
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/ncurses/libncurses9/$LNCURSES.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/readline/libreadline7/$READLINE.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/readline/$READLINE_DEV.tar.bz2

#Unzip.
tar xjf $ZIP.tar.bz2 -C / #Needed for packaging.
tar xzf $CGDB.tar.gz
tar xjf $LNCURSES.tar.bz2
tar xjf $READLINE.tar.bz2
tar xjf $READLINE_DEV.tar.bz2

#Move dependencies in place.
cp -r ./usr/* /usr/

#Patch and build.
cd $CGDB
patch -p1 < ../../cgdb.patch
./configure
make
make install

#Move sources in place for packaging.
## Bin directory.
mkdir $PKG_NAME
mkdir $PKG_NAME/bin
###cp -r usr/bin/* $PKG_NAME/bin
## Lib directory.
###mkdir $PKG_NAME/lib
###cp -r usr/lib/* $PKG_NAME/lib
## Include and Share directory.
mkdir $PKG_NAME/usr
###cp -r usr/include $PKG_NAME/usr
###cp -r usr/share $PKG_NAME/usr
cp usr/bin/$LNCURSES_BIN $PKG_NAME/bin
cp usr/bin/$READLINE_BIN $PKG_NAME/bin
cp /usr/local/bin/* $PKG_NAME/bin
cp -r /usr/local/share $PKG_NAME/usr

#Build package.
cd $PKG_NAME
zip -r $PKG_NAME.mxt3 .
mv $PKG_NAME.mxt3 ../../
echo "Created package $PKG_NAME.mxt3 successfully!" 
