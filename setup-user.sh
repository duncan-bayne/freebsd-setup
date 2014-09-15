#!/bin/sh

set -e

./install_rbenv.sh

if grep -q "037b7c29-5804-43e2-8054-d1ebfb0f3293" ~/.profile;
then
    echo Shell confugration extras already added to ~/.profile.
else
    echo Adding custom Shell setup to ~/profile
    if [ ! -d ~/bin ]; then mkdir ~/bin ; fi
    echo >> ~/.profile
    echo \# Personal Shell configuration extras, added by freebsd-setup >> ~/.profile
    echo \# 037b7c29-5804-43e2-8054-d1ebfb0f3293 >> ~/.profile
    echo . ~/freebsd-setup/conf/shell/shell_extras.sh >> ~/.profile
    echo >> ~/.profile
fi
