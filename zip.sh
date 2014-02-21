#!/bin/sh
echo "Starting..."

#Stop on error.
set -e

#Output name.
PKG_NAME=Zip

#Sources and dependency names.
ZIP=zip-3.0-11

#Clean up.
rm -rf .working_dir
mkdir .working_dir
cd .working_dir

#Grab sources and dependencies.
echo "Grabbing sources..."
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/zip/$ZIP.tar.bz2

#Unzip.
echo "Unzipping sources..."
tar xjf $ZIP.tar.bz2 -C / #Needed for packaging.
tar xjf $ZIP.tar.bz2

#Move sources in place for packaging.
echo "Creating package basis..."
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

#Build package.
echo "Building package..."
cd $PKG_NAME
zip -r $PKG_NAME.mxt3 .
mv $PKG_NAME.mxt3 ../../
echo "Created package $PKG_NAME.mxt3 successfully!" 
