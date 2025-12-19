#!/bin/bash

#Download latest version of Zen browser format in .tar.xz
wget https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz

# Unpack tar file
tar -xf zen.linux-x86_64.tar.xz

# Get version number in zen/application.ini for deb package
VERSION=$(cat zen/application.ini | grep Version= | head -1 | cut -f2 -d"=")

# Create deb package structure
mkdir deb/{opt,DEBIAN,usr/share/applications/,usr/bin/} -p

# Copy file of zen and .desktop file in deb package
cp -r zen deb/opt/
cp app.zen_browser.zen.desktop deb/usr/share/applications/
cp control deb/DEBIAN/control

# Edit control with new informations
sed -i "s/\$package/zen-browser/g" deb/DEBIAN/control
sed -i "s/\$version/$VERSION/g" deb/DEBIAN/control

# Create link of binary for /usr/bin
cd deb/usr/bin

ln -s ../../opt/zen/zen .

cd ../../../

# Create build package

dpkg-deb --root-owner-group -b deb/ zen.linux-x86_64.deb




