#!/bin/bash

apt-get update
apt-get install -y clang-3.6 libicu-dev
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100

#wget https://swift.org/builds/development/ubuntu1404/swift-DEVELOPMENT-SNAPSHOT-2016-03-01-a/swift-DEVELOPMENT-SNAPSHOT-2016-03-01-a-ubuntu14.04.tar.gz

tar -xvf swift-DEVELOPMENT-SNAPSHOT-2016-03-01-a-ubuntu14.04.tar.gz
cp -r swift-DEVELOPMENT-SNAPSHOT-2016-03-01-a-ubuntu14.04/usr/* /usr/

rm -rf swift-DEVELOPMENT-SNAPSHOT-2016-03-01-a-ubuntu14.04
rm -f swift-DEVELOPMENT-SNAPSHOT-2016-03-01-a-ubuntu14.04.tar.gz

# Create an empty swift project
mkdir -p /swifttests/
cd /swifttests
swift build --init
rm -f Sources/main.swift
