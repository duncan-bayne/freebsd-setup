#!/bin/sh

set -e

echo Configuring build options...
touch /etc/make.conf
echo >> /etc/make.conf
echo \# Custom build options, added by freebsd-setup >> /etc/make.conf
echo WITH_KMS=yes >> /etc/make.conf
echo WITH_NEW_XORG=yes >> /etc/make.conf
echo BATCH=yes >> /etc/make.conf
echo >> /etc/make.conf

echo Installing SVN...
cd /usr/ports/devel/subversion
make clean install

echo Installing packages due to some temporarily broken ports...
pkg install cmake

# TODO - use packages instead
echo Installing and configuring ports...
portmaster audio/openal-soft
portmaster databases/freetds
portmaster databases/mysql56-client
portmaster databases/mysql56-server
portmaster devel/cunit
portmaster devel/git
portmaster devel/mercurial
portmaster devel/shtool
portmaster editors/emacs
portmaster editors/libreoffice
portmaster ftp/wget
portmaster games/minecraft-client
portmaster graphics/ImageMagick
portmaster graphics/xpdf
portmaster lang/go
portmaster lang/ruby21
portmaster lang/sbcl
portmaster multimedia/vlc
portmaster net/unison
portmaster security/ccrypt
portmaster shells/zsh
portmaster sysutils/brasero
portmaster www/chromium
portmaster www/firefox
portmaster www/links
portmaster x11-drivers/xf86-input-keyboard
portmaster x11-drivers/xf86-input-mouse
portmaster x11/terminator
portmaster x11/xbrightness
portmaster x11/xclip
portmaster x11/xorg

pkg install cups
pkg install i386-wine
pkg install print/cups-smb-backend
pkg install print/gutenberg-cups
pkg install print/hplip
pkg install rsync
pkg install xmixer

echo Installing fortune...
cd /usr/src/games/fortune
make
make install

echo Configuring Virtualbox...
cd /usr/src
make toolchain build32 install32
/etc/rc.d/ldconfig restart
portmaster emulators/virtualbox-ose

./setup-xorg-usb-desktop.sh

echo Configuring boot splash...
touch /boot/loader.conf
echo >> /boot/loader.conf
echo \# Boot splash settings, added by freebsd-setup >> /boot/loader.conf
echo loader_logo=\"freebsd-setup-logo\" >> /boot/loader.conf
echo >> /boot/loader.conf
cp -f conf/beastie.4th /boot/beastie.4th

./setup-printing.sh

echo Configuring cdrecord for non-root access...
chown root /usr/local/bin/cdrecord
chmod 4711 /usr/local/bin/cdrecord

