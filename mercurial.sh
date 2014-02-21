#!/bin/sh

#Stop on error.
set -e

#Output name.
PKG_NAME=Mercurial

#Sources and dependency names.
ZIP=zip-3.0-11
HG=mercurial-2.7.1-1

#Clean up.
rm -rf .working_dir
mkdir .working_dir
cd .working_dir

#Grab sources and dependencies.
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/zip/$ZIP.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/mercurial/$HG.tar.bz2

#Unzip.
tar xjf $ZIP.tar.bz2 -C / #Needed for packaging.
tar xjf $HG.tar.bz2

#Move sources in place for packaging.
mkdir $PKG_NAME
mkdir $PKG_NAME/bin
mkdir $PKG_NAME/usr
mkdir $PKG_NAME/lib
cp usr/bin/* $PKG_NAME/bin
cp -r usr/share $PKG_NAME/usr
cp -r usr/lib/* $PKG_NAME/lib

#Build package.
cd $PKG_NAME
zip -r $PKG_NAME.mxt3 .
mv $PKG_NAME.mxt3 ../../
echo "Created package $PKG_NAME.mxt3 successfully!" 
