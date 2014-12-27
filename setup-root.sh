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

echo Installing some initially useful packages...
pkg install -y git
pkg install -y links
pkg install -y subversion
pkg install -y terminator
pkg install -y wget

echo Installing and configuring X, StumpWM and dependencies...
pkg install -y xorg
pkg install -y x11-drivers/xf86-input-keyboard
pkg install -y x11-drivers/xf86-input-mouse
pkg install -y xbrightness
pkg install -y xclip
pkg install -y xmixer
./install-stumpwm.sh

echo Installing miscellaneous packages...
pkg install -y autoconf
pkg install -y ccrypt
pkg install -y chromium
pkg install -y cmake
pkg install -y cunit
pkg install -y cups
pkg install -y editors/emacs
pkg install -y firefox
pkg install -y freetds
pkg install -y gmake
pkg install -y go
pkg install -y i386-wine
pkg install -y ImageMagick
pkg install -y libreoffice
pkg install -y mercurial
pkg install -y minecraft-client
pkg install -y mysql56-client
pkg install -y mysql56-server
pkg install -y openal-soft
pkg install -y print/cups-smb-backend
pkg install -y print/gutenprint-cups
pkg install -y print/hplip
pkg install -y rsync
pkg install -y ruby21
pkg install -y shtool
pkg install -y sudo
pkg install -y unison
pkg install -y virtualbox-ose
pkg install -y virtualbox-ose-additions
pkg install -y virtualbox-ose-kmod
pkg install -y vlc
pkg install -y xpdf
pkg install -y zsh

echo Installing fortune...
cd /usr/src/games/fortune
make
make install
cd ~/freebsd-setup

echo Configuring Virtualbox...
echo >> /etc/rc.conf
echo \# VirtualBox settings, added by freebsd-setup >> /etc/rc.conf
echo vboxnet_enable=\"YES\" >> /etc/rc.conf
echo >> /etc/rc.conf

./setup-xorg-usb-desktop.sh

# TODO: enable this, after fixing beastie.4th
# echo Configuring boot splash...
# touch /boot/loader.conf
# echo >> /boot/loader.conf
# echo \# Boot splash settings, added by freebsd-setup >> /boot/loader.conf
# echo loader_logo=\"freebsd-setup-logo\" >> /boot/loader.conf
# echo >> /boot/loader.conf
# cp -f conf/boot/beastie.4th /boot/beastie.4th

./setup-printing.sh

echo Configuring cdrecord for non-root access...
chown root /usr/local/bin/cdrecord
chmod 4711 /usr/local/bin/cdrecord

echo Enabling NTP...
echo >> /etc/rc.conf
echo \# NPT settings, added by freebsd-setup >> /etc/rc.conf
echo ntpd_enable=\"YES\" >> /etc/rc.conf
echo ntpdate_enable=\"YES\" >> /etc/rc.conf
echo >> /etc/rc.conf

echo Installing Skype...
kldload linux
portmaster net-im/skype
