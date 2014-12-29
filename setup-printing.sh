#!/bin/sh

set -e

echo Configuring CUPS...
echo >> /etc/rc.conf
echo \# CUPS configuration, added by freebsd-setup >> /etc/rc.conf
echo cupsd_enable="YES" >> /etc/rc.conf

echo >> /etc/devfs.rules
echo \# CUPS configuration, added by freebsd-setup >> /etc/devfs.rules
echo [system=10] >> /etc/devfs.rules
echo add path \'unlpt*\' mode 0660 group cups >> /etc/devfs.rules
echo add path \'ulpt*\' mode 0660 group cups >> /etc/devfs.rules
echo add path \'lpt*\' mode 0660 group cups >> /etc/devfs.rules

touch /usr/local/etc/smb.conf
