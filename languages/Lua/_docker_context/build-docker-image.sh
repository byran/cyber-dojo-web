#!/bin/bash

docker rmi cyberdojofoundation/lua-5.3.2
docker build -t cyberdojofoundation/lua-5.3.2 .
