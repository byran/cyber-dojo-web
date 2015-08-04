#!/bin/bash

docker run --privileged --name=$1 --restart=always -p 80:80 -t -d adgico/cyber-dojo

