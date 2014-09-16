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

# TODO: install these with portmaster
# git
# sbcl
# xorg (including hald)
# firefox
# chromium (including shared-memory enable)
# links
# ccrypt
# unison
# ruby21
# emacs

