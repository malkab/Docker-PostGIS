#!/bin/bash

# Final release of binaries
mkdir -p /ext-out/binaries

cp --parents -r /usr/local/bin/ /ext-out/binaries
cp --parents -r /usr/local/lib/ /ext-out/binaries
cp --parents -r /usr/local/share/ /ext-out/binaries
cp --parents /lib/x86_64-linux-gnu/libssl.so.1.0.0 /ext-out/binaries
cp --parents /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /ext-out/binaries
cp --parents /lib/x86_64-linux-gnu/libjson-c.so.2 /ext-out/binaries
cp --parents /usr/lib/x86_64-linux-gnu/libxml2.so.2 /ext-out/binaries
cp --parents /usr/lib/x86_64-linux-gnu/libicuuc.so.55 /ext-out/binaries
cp --parents /usr/lib/x86_64-linux-gnu/libicudata.so.55 /ext-out/binaries
