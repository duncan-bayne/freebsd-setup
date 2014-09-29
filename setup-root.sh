#!/bin/sh

set -e

# don't put this in /etc/make.conf; I think we could, but hilarity might ensure later :-|
export BATCH=yes

if grep -q "037b7c29-5804-43e2-8054-d1ebfb0f3293" /etc/make.conf;
then
    echo Custom build options already added to /etc/make.conf.
else
    echo >> /etc/make.conf
    echo \# Custom build options, added by freebsd-setup >> /etc/make.conf
    echo \# 037b7c29-5804-43e2-8054-d1ebfb0f3293 >> /etc/make.conf
    echo WITH_NEW_XORG=\"YES\" >> /etc/make.conf
    echo >> /etc/make.conf
fi

echo Installing SVN...
cd /usr/ports/devel/subversion
make clean install

echo Getting kernel sources...
svn co svn://svn.freebsd.org/base/stable/10 /usr/src

echo Installing portmaster...
cd /usr/ports/ports-mgmt/portmaster
make clean install

echo Installing and configuring ports...
portmaster databases/freetds
portmaster databases/mysql56-client
portmaster databases/mysql56-server
portmaster devel/cunit
portmaster devel/git
portmaster devel/shtool
portmaster editors/emacs
portmaster editors/libreoffice
portmaster ftp/wget
portmaster graphics/ImageMagick
portmaster lang/ruby21
portmaster lang/sbcl
portmaster multimedia/vlc
portmaster net/unison
portmaster security/ccrypt
portmaster sysutils/brasero
portmaster www/chromium
portmaster www/firefox
portmaster www/links
portmaster x11-drivers/xf86-input-keyboard
portmaster x11-drivers/xf86-input-mouse
portmaster x11/terminator
portmaster x11/xorg

if grep -q "037b7c29-5804-43e2-8054-d1ebfb0f3293" /etc/rc.conf;
then
    echo Xorg, USB services already added to /etc/rc.conf.
else
    echo >> /etc/rc.conf
    echo \# Xorg and USB services, added by freebsd-setup >> /etc/rc.conf
    echo \# 037b7c29-5804-43e2-8054-d1ebfb0f3293 >> /etc/rc.conf
    echo hald_enable=\"YES\" >> /etc/rc.conf
    echo dbus_enable=\"YES\" >> /etc/rc.conf
    echo devfs_system_ruleset=\"usb_devices\" >> /etc/rc.conf
    echo >> /etc/rc.conf
fi

if grep -q "037b7c29-5804-43e2-8054-d1ebfb0f3293" /etc/sysctl.conf;
then
    echo Enhanced desktop settings already added to /etc/sysctl.conf.
else
    echo >> /etc/sysctl.conf
    echo \# Enhanced desktop settings, some required by Chromium, added by freebsd-setup >> /etc/sysctl.conf
    echo \# Thanks to https://cooltrainer.org/a-freebsd-desktop-howto/ >> /etc/sysctl.conf
    echo \# 037b7c29-5804-43e2-8054-d1ebfb0f3293 >> /etc/sysctl.conf
    echo kern.ipc.shmmax=67108864 >> /etc/sysctl.conf
    echo kern.ipc.shmall=32768 >> /etc/sysctl.conf
    echo kern.sched.preempt_thresh=224 >> /etc/sysctl.conf
    echo kern.maxfiles=200000 >> /etc/sysctl.conf
    echo kern.ipc.shm_allow_removed=1 >> /etc/sysctl.conf
    echo vfs.usermount=1 >> /etc/sysctl.conf
    echo >> /etc/sysctl.conf
fi

echo Adding group and config for USB access...
pw groupadd usb
touch /etc/devfs.rules
if grep -q "037b7c29-5804-43e2-8054-d1ebfb0f3293" /etc/devfs.rules;
then
    echo Enhanced desktop settings already added to /etc/devfs.rules.
else
    echo >> /etc/devfs.rules
    echo \# USB access for non-root users, added by freebsd-setup >> /etc/devfs.rules
    echo \# Thanks to http://mcuee.blogspot.com.au/2007/11/setting-up-permissions-for-usb-ports-to.html >> /etc/devfs.rules
    echo \# 037b7c29-5804-43e2-8054-d1ebfb0f3293 >> /etc/devfs.rules
    echo [usb_devices=10] >> /etc/devfs.rules
    echo add path \'ugen*\' mode 0660 group usb >> /etc/devfs.rules
    echo add path \'da*s*\' mode 0660 group usb >> /etc/devfs.rules
    echo >> /etc/devfs.rules
fi
if grep -q "037b7c29-5804-43e2-8054-d1ebfb0f3293" /etc/devfs.conf;
then
    echo Enhanced desktop settings already added to /etc/devfs.conf.
else
    echo >> /etc/devfs.conf
    echo \# USB access for non-root users, added by freebsd-setup >> /etc/devfs.conf
    echo \# Thanks to http://mcuee.blogspot.com.au/2007/11/setting-up-permissions-for-usb-ports-to.html >> /etc/devfs.conf
    echo \# 037b7c29-5804-43e2-8054-d1ebfb0f3293 >> /etc/devfs.conf
    echo perm usb0 0660 >> /etc/devfs.conf
    echo own usb0 root:usb >> /etc/devfs.conf
    echo perm usb1 0660 >> /etc/devfs.conf
    echo own usb1 root:usb >> /etc/devfs.conf
    echo >> /etc/devfs.conf
fi

echo Configuring boot splash...
if grep -q "037b7c29-5804-43e2-8054-d1ebfb0f3293" /boot/loader.conf;
then
    echo Boot splash settings already added to /boot/loader.conf
else
    echo >> /boot/loader.conf
    echo \# Boot splash settings, added by freebsd-setup >> /boot/loader.conf
    echo \# 037b7c29-5804-43e2-8054-d1ebfb0f3293 >> /boot/loader.conf
    echo loader_logo=\"freebsd-setup-logo\" >> /boot/loader.conf
    echo >> /boot/loader.conf
fi
if grep -q "037b7c29-5804-43e2-8054-d1ebfb0f3293" /boot/beastie.4th;
then
    echo Already using custom beastie.4th.
else
    cp -f conf/beastie.4th /boot/beastie.4th
fi
