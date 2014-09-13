#!/bin/sh

set -e

echo Installing Git...
cd /usr/ports/devel/git
make && make install

echo Installing SBCL...
cd /usr/ports/lang/sbcl
make && make install

echo Installing XOrg...
cd /usr/ports/x11/xorg
make && make install

