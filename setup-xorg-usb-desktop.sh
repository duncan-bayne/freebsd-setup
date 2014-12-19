#!/bin/sh

set -e

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
