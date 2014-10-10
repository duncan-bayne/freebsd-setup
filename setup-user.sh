#!/bin/sh

set -e

./install-rbenv.sh
./install-stumpwm.sh

git config --global push.default matching

if grep -q "037b7c29-5804-43e2-8054-d1ebfb0f3293" ~/.zshrc
then
    echo Shell confugration extras already added to ~/.zshrc.
else
    echo Adding custom Shell setup to ~.zshrc
    echo >> ~/.zshrc
    echo \# Personal Shell configuration extras, added by freebsd-setup >> ~/.zshrc
    echo \# 037b7c29-5804-43e2-8054-d1ebfb0f3293 >> ~/.zshrc
    echo . ~/freebsd-setup/conf/shell/shell_extras.sh >> ~/.zshrc
    echo >> ~/.zshrc
fi

rm -f ~/bin
ln -s ~/freebsd-setup/conf/bin ~/bin

if [ ! -f ~/.stumpwmrc ]; then ln -s ~/freebsd-setup/conf/stumpwm/stumpwmrc ~/.stumpwmrc; fi

echo Adding $USER to usb group...
sudo pw groupmod usb -M $USER

echo Switching to zsh...
chsh -s /usr/local/bin/zsh
