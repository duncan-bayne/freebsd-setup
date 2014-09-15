#!/bin/sh

set -e

echo Installing SVN...
cd /usr/ports/devel/subversion
make install

echo Getting kernel sources...
svn co svn://svn.freebsd.org/base/stable/10 /usr/src

echo Installing Git...
cd /usr/ports/devel/git
make install

echo Installing SBCL...
cd /usr/ports/lang/sbcl
make install

echo Installing Links...
cd /usr/ports/www/links
make install

echo Installing XOrg...
cd /usr/ports/x11/xorg
make install

echo Installing ccrypt...
cd /usr/ports/security/ccrypt
make install

echo Installing Unison...
cd /usr/ports/net/unison
make install

echo Installing Ruby...
cd /usr/ports/lang/ruby
make install

echo Installing Emacs...
cd /usr/ports/editors/emacs
make install

