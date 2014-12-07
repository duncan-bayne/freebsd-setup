#!/bin/sh

set -e

pkg install -y autoconf
pkg install -y gmake
portmaster lang/sbcl

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

