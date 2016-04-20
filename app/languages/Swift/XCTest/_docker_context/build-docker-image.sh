#!/bin/bash

docker rmi cyberdojofoundation/swift_xctest
docker build -t cyberdojofoundation/swift_xctest .
