#!/bin/sh

set -e

sudo pkg install -y autoconf
sudo pkg install -y gmake
sudo portmaster lang/sbcl

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
sudo make install
echo exec stumpwm > ~/.xinitrc

