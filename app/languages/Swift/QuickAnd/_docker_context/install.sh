#!/bin/bash

git clone https://github.com/Quick/Quick.git
cd Quick
swift build

cd /
cp Quick/.build/debug/Nimble.a .
cp Quick/.build/debug/Quick.a .
#cp Quick/.build/debug/Nimble.o .
#cp Quick/.build/debug/Quick.o .

#rm -rf Quick
