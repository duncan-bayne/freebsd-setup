#!/bin/sh

set -e

pkg install -y clisp

rm -rf ~/sbcl-install
cd ~/sbcl-install
wget http://aarnet.dl.sourceforge.net/project/sbcl/sbcl/1.2.6/sbcl-1.2.6-source.tar.bz2
bunzip2 sbcl-1.2.6-source.tar.bz2
tar -zxvf sbcl-1.2.6-source.tar
cd sbcl-1.2.6
./configure
make install
cd ~/freebsd-setup

pkg delete -y clisp

rm -rf ~/stumpwm-install
git clone https://github.com/stumpwm/stumpwm.git ~/stumpwm-install
cp stumpwm-deps.lisp ~/stumpwm-install
cd ~/stumpwm-install

curl -O http://beta.quicklisp.org/quicklisp.lisp
if [ ! -d ~/quicklisp ]; then sbcl --load quicklisp.lisp --eval "(progn (quicklisp-quickstart:install)(quit))" ; fi
sbcl --script ./stumpwm-deps.lisp

autoconf
./configure
make
echo exec stumpwm > ~/.xinitrc

