#!/bin/bash

wget https://github.com/bluebird75/luaunit/releases/download/LUAUNIT_V3_1/luaunit-3.1.tar.gz

tar -xvf luaunit-3.1.tar.gz
mkdir -p /usr/local/share/lua/5.3/
cp luaunit-3.1/luaunit.lua /usr/local/share/lua/5.3/luaunit.lua

rm -rf luaunit-3.1
rm -f luaunit-3.1.tar.gz
