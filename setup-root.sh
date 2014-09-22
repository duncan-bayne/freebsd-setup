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
portmaster devel/git
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
    echo Xorg services already added to /etc/rc.conf.
else
    echo >> /etc/rc.conf
    echo \# Xorg services, added by freebsd-setup >> /etc/rc.conf
    echo \# 037b7c29-5804-43e2-8054-d1ebfb0f3293 >> /etc/rc.conf
    echo hald_enable=\"YES\" >> /etc/rc.conf
    echo dbus_enable=\"YES\" >> /etc/rc.conf
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
