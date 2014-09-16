#!/bin/sh

set -e

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

portmaster x11/xorg
portmaster x11-drivers/xf86-input-keyboard
portmaster x11-drivers/xf86-input-mouse
portmaster x11/terminator

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

portmaster lang/sbcl

# TODO: install these with portmaster
# git
# firefox
# chromium (including shared-memory enable)
# links
# ccrypt
# unison
# ruby21
# emacs

