#!/bin/bash

# Final release of binaries
mkdir -p /ext-out/binaries

cp --parents -r /usr/local/bin/ /ext-out/binaries
cp --parents -r /usr/local/lib/ /ext-out/binaries
cp --parents -r /usr/local/share/ /ext-out/binaries

