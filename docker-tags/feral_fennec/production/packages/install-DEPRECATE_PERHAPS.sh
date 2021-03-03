#!/bin/bash

# Install binaries and libs

cp -r /binaries/usr/local/bin/* /usr/local/bin
cp -r /binaries/usr/local/lib/* /usr/local/lib
cp -r /binaries/lib/x86_64-linux-gnu/* /lib/x86_64-linux-gnu
cp -r /binaries/usr/lib/x86_64-linux-gnu/* /usr/lib/x86_64-linux-gnu
cp -r /binaries/usr/local/share/* /usr/local/share

chmod 777 /usr/local/bin/*

# rm -Rf /binaries
