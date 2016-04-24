#!/bin/bash

swiftc main.swift /Quick.a -o main -I / -L / -Xlinker -rpath -Xlinker @executable_path/ -v
