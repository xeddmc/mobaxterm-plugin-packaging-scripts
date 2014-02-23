#!/bin/sh
echo "Starting..."

#Stop on error.
set -e

#Output name.
PKG_NAME=Graphviz

#Sources and dependency names.
ZIP=zip-3.0-11
GRAPHVIZ=graphviz-2.36.0-1
LCDT=libcdt5-2.36.0-1
LCGRAPH=libcgraph6-2.36.0-1
LEXPAT=libexpat1-2.1.0-3
LGD2=libgd2-2.0.36RC1-13
GLIB20=libglib2.0_0-2.36.4-4
LGTS=libgts0.7_5-20121130-1
LGVC6=libgvc6-2.36.0-1
LGVPR2=libgvpr2-2.36.0-1
LPATHPLAN4=libpathplan4-2.36.0-1
#LX11_6=libX11_6-1.6.2-1 #Unneeded
LXAW7=libXaw7-1.0.12-1
LXMU6=libXmu6-1.1.2-1
LXT6=libXt6-1.1.4-1

#Clean up.
rm -rf .working_dir
mkdir .working_dir
cd .working_dir

#Grab sources and dependencies.
echo "Grabbing sources..."
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/zip/$ZIP.tar.bz2
wget ftp://ftp.cygwinports.org/pub/cygwinports/x86/release/graphviz/$GRAPHVIZ.tar.xz
wget ftp://ftp.cygwinports.org/pub/cygwinports/x86/release/graphviz/libcdt5/$LCDT.tar.xz
wget ftp://ftp.cygwinports.org/pub/cygwinports/x86/release/graphviz/libcgraph6/$LCGRAPH.tar.xz
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/expat/libexpat1/$LEXPAT.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/X11/gd/libgd2/$LGD2.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/glib2.0/libglib2.0_0/$GLIB20.tar.xz
wget ftp://ftp.cygwinports.org/pub/cygwinports/x86/release/gts/libgts0.7_5/$LGTS.tar.bz2
wget ftp://ftp.cygwinports.org/pub/cygwinports/x86/release/graphviz/libgvc6/$LGVC6.tar.xz
wget ftp://ftp.cygwinports.org/pub/cygwinports/x86/release/graphviz/libgvpr2/$LGVPR2.tar.xz
wget ftp://ftp.cygwinports.org/pub/cygwinports/x86/release/graphviz/libpathplan4/$LPATHPLAN4.tar.xz
#wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/libX11/libX11_6/$LX11_6.tar.xz
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/libXaw/libXaw7/$LXAW7.tar.xz
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/libXmu/libXmu6/$LXMU6.tar.xz
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/libXt/libXt6/$LXT6.tar.bz2

#Unzip.
echo "Unzipping sources..."
tar xjf $ZIP.tar.bz2 -C / #Needed for packaging.
tar xf $GRAPHVIZ.tar.xz
tar xf $LCDT.tar.xz
tar xf $LCGRAPH.tar.xz
tar xjf $LEXPAT.tar.bz2
tar xjf $LGD2.tar.bz2
tar xf $GLIB20.tar.xz
tar xjf $LGTS.tar.bz2
tar xf $LGVC6.tar.xz
tar xf $LGVPR2.tar.xz
tar xf $LPATHPLAN4.tar.xz
#tar xf $LX11_6.tar.xz
tar xf $LXAW7.tar.xz
tar xf $LXMU6.tar.xz
tar xjf $LXT6.tar.bz2

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
###cp -r usr/include $PKG_NAME/usr
cp -r usr/share $PKG_NAME/usr
#Generate config
cp -r $PKG_NAME/* / #copy over config files.
ls /bin/cygltdl-7.dll #ls, otherwise it won't unzip.
dot -c #generate.
cp -r /lib/graphviz-* $PKG_NAME/lib #copy into place.

#Build package.
echo "Building package..."
cd $PKG_NAME
zip -r $PKG_NAME.mxt3 .
mv $PKG_NAME.mxt3 ../../
echo "Created package $PKG_NAME.mxt3 successfully!" 
