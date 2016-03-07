#!/bin/bash

apt-get update
apt-get install -y wget libreadline-dev

wget http://www.lua.org/ftp/lua-5.3.2.tar.gz
tar -xvf lua-5.3.2.tar.gz

cd lua-5.3.2
make linux install

cd ..
rm -rf lua-5.3.2
rm -f lua-5.3.2.tar.gz
