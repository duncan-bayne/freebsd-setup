#!/bin/sh

set -e

./install-rbenv.sh
./install-stumpwm.sh

git config --global push.default matching

rm -f ~/bin
ln -s ~/freebsd-setup/conf/bin ~/bin

if [ ! -f ~/.stumpwmrc ]; then ln -s ~/freebsd-setup/conf/stumpwm/stumpwmrc ~/.stumpwmrc; fi

echo Adding $USER to usb group...
sudo pw groupmod usb -M $USER

echo Switching to zsh and installing Oh My ZSH
chsh -s /usr/local/bin/zsh
curl -L http://install.ohmyz.sh | sh
ln ~/freebsd-setup/conf/zsh/freebsd-setup.zsh ~/.oh-my-zsh/custom/freebsd-setup.zsh
