#!/bin/sh

set -e

cd ~
rm -rf ~/.rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

# HACK: this is a temporary workaround for https://github.com/duncan-bayne/freebsd-setup/issues/49
sudo pkg install -y ruby
