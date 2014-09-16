#!/bin/sh

set -e

echo Installing SVN...
cd /usr/ports/devel/subversion
make clean install

echo Getting kernel sources...
svn co svn://svn.freebsd.org/base/stable/10 /usr/src

echo Installing portmaster...
cd /usr/ports/ports-mgmt/portmaster
make clean install

echo WITH_NEW_XORG="YES" >> /etc/make.conf
export BATCH=yes

portmaster x11/xorg
postmaster x11-drivers/xf86-input-keyboard
postmaster x11-drivers/xf86-input-mouse

# TODO: install these with portmaster
# git
# sbcl
# firefox
# chromium (including shared-memory enable)
# links
# ccrypt
# unison
# ruby21
# emacs

