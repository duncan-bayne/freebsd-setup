#!/bin/sh

set -e

cd ~
rm -rf ~/.rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

# initialize rbenv so we can use it without restarting the shell
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

echo Installing Ruby 2.0.0 with rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 2.0.0-p598
rbenv global 2.0.0-p598
rbenv rehash

# fix an annoying FreeBSD cert bug
SSL_CERT_FILE=/usr/local/etc/ssl/cert.pem gem update --system

gem install bundler
rbenv rehash

