#!/bin/sh
echo "Starting..."

#Stop on error.
set -e

#Output name.
PKG_NAME=Python

#Sources and dependency names.
ZIP=zip-3.0-11
PYTHON=python-2.7.3-1
PYTHON_VER=python2.7
CRYPT=crypt-1.2-1
LBZ2=libbz2_1-1.0.6-2
LDB=libdb4.5-4.5.20.2-3
LEXPAT=libexpat1-2.1.0-3
LFFI=libffi4-4.5.3-3
LGDBM=libgdbm4-1.8.3-20
LINTL=libintl8-0.18.1.1-2
NCURSESW=libncursesw10-5.7-18
READLINE=libreadline7-6.1.2-3
SQLITE=libsqlite3_0-3.8.3.1-1
LOPENSSL98=libopenssl098-0.9.8y-1
#LOPENSSL100=libopenssl100-1.0.1f-3 #breaks wget -- DO NOT ENABLE.
ZLIB0=zlib0-1.2.8-1

#Clean up.
rm -rf .working_dir
mkdir .working_dir
cd .working_dir

#Grab sources and dependencies.
echo "Grabbing sources..."
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/zip/$ZIP.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/python/$PYTHON.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/crypt/$CRYPT.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/bzip2/libbz2_1/$LBZ2.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/db/db4.5/libdb4.5/$LDB.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/expat/libexpat1/$LEXPAT.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/gcc/libffi4/$LFFI.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/gdbm/libgdbm4/$LGDBM.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/gettext/libintl8/$LINTL.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/ncursesw/libncursesw10/$NCURSESW.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/readline/libreadline7/$READLINE.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/sqlite3/libsqlite3_0/$SQLITE.tar.xz
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/openssl/libopenssl098/$LOPENSSL98.tar.bz2
#wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/openssl/libopenssl100/$LOPENSSL100.tar.xz
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/zlib/zlib0/$ZLIB0.tar.bz2

#Unzip.
echo "Unzipping sources..."
tar xjf $ZIP.tar.bz2 -C / #Needed for packaging.
tar xjf $PYTHON.tar.bz2
tar xjf $CRYPT.tar.bz2
tar xjf $LBZ2.tar.bz2
tar xjf $LDB.tar.bz2
tar xjf $LEXPAT.tar.bz2
tar xjf $LFFI.tar.bz2
tar xjf $LGDBM.tar.bz2
tar xjf $LINTL.tar.bz2
tar xjf $NCURSESW.tar.bz2
tar xjf $READLINE.tar.bz2
tar xf $SQLITE.tar.xz
tar xjf $LOPENSSL98.tar.bz2
#tar xf $LOPENSSL100.tar.xz
tar xjf $ZLIB0.tar.bz2

#Move sources in place for packaging.
echo "Creating package basis..."
## Bin directory.
mkdir $PKG_NAME
mkdir $PKG_NAME/bin
cp -r usr/bin/* $PKG_NAME/bin
## Lib directory.
mkdir $PKG_NAME/lib
cp -r usr/lib/* $PKG_NAME/lib
## Include and Share directory.
mkdir $PKG_NAME/usr
cp -r usr/include $PKG_NAME/usr
cp -r usr/share $PKG_NAME/usr
# Fix errors with python executable:
rm $PKG_NAME/bin/python
cp $PKG_NAME/bin/$PYTHON_VER.exe $PKG_NAME/bin/python.exe 

#Build package.
echo "Building package..."
cd $PKG_NAME
zip -r $PKG_NAME.mxt3 .
mv $PKG_NAME.mxt3 ../../
echo "Created package $PKG_NAME.mxt3 successfully!" 
