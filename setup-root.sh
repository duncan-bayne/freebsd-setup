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

pkg install rsync

echo Installing fortune...
cd /usr/src/games/fortune
make
make install

echo Configuring Virtualbox...
cd /usr/src
make toolchain build32 install32
/etc/rc.d/ldconfig restart
portmaster emulators/virtualbox-ose

echo Configuring Xorg and USB...

touch /etc/rc.conf
echo >> /etc/rc.conf
echo \# Xorg and USB services, added by freebsd-setup >> /etc/rc.conf
echo hald_enable=\"YES\" >> /etc/rc.conf
echo dbus_enable=\"YES\" >> /etc/rc.conf
echo devfs_system_ruleset=\"usb_devices\" >> /etc/rc.conf
echo >> /etc/rc.conf

echo >> /etc/devfs.rules
echo \# USB access for non-root users, added by freebsd-setup >> /etc/devfs.rules
echo \# Thanks to http://mcuee.blogspot.com.au/2007/11/setting-up-permissions-for-usb-ports-to.html >> /etc/devfs.rules
echo [usb_devices=10] >> /etc/devfs.rules
echo add path \'ugen*\' mode 0660 group usb >> /etc/devfs.rules
echo add path \'da*s*\' mode 0660 group usb >> /etc/devfs.rules
echo >> /etc/devfs.rules

touch /etc/devfs.rules
touch /etc/devfs.conf
pw groupadd usb
pw group mod operator -m $USER
pw group mod pulse-access -m $USER
pw group mod wheel -m $USER

echo Desktop settings...
touch /etc/sysctl.conf
echo >> /etc/sysctl.conf
echo \# Enhanced desktop settings, some required by Chromium, added by freebsd-setup >> /etc/sysctl.conf
echo \# Thanks to https://cooltrainer.org/a-freebsd-desktop-howto/ >> /etc/sysctl.conf
echo kern.ipc.shmmax=67108864 >> /etc/sysctl.conf
echo kern.ipc.shmall=32768 >> /etc/sysctl.conf
echo kern.sched.preempt_thresh=224 >> /etc/sysctl.conf
echo kern.maxfiles=200000 >> /etc/sysctl.conf
echo kern.ipc.shm_allow_removed=1 >> /etc/sysctl.conf
echo vfs.usermount=1 >> /etc/sysctl.conf
echo >> /etc/sysctl.conf

echo Adding group and config for USB and other device access...
echo >> /etc/devfs.conf
echo \# USB access for non-root users, added by freebsd-setup >> /etc/devfs.conf
echo \# Thanks to http://mcuee.blogspot.com.au/2007/11/setting-up-permissions-for-usb-ports-to.html >> /etc/devfs.conf
echo perm usb0 0660 >> /etc/devfs.conf
echo own usb0 root:usb >> /etc/devfs.conf
echo perm usb1 0660 >> /etc/devfs.conf
echo own usb1 root:usb >> /etc/devfs.conf
echo >> /etc/devfs.conf

echo Configuring boot splash...
touch /boot/loader.conf
echo >> /boot/loader.conf
echo \# Boot splash settings, added by freebsd-setup >> /boot/loader.conf
echo loader_logo=\"freebsd-setup-logo\" >> /boot/loader.conf
echo >> /boot/loader.conf
cp -f conf/beastie.4th /boot/beastie.4th
