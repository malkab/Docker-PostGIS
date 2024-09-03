#!/bin/bash

cd /usr/local/src/postgresql-$PG_VERSION

echo
echo -----------------------------------------------------------------
echo
echo Configure
echo
echo -----------------------------------------------------------------
echo

./configure \
	--prefix=/usr/local \
	--with-pgport=5432 \
	--with-python \
	--with-openssl \
	--with-libxml \
	--with-libxslt \
	--with-zlib

echo
echo -----------------------------------------------------------------
echo
echo Build
echo
echo -----------------------------------------------------------------
echo

make

echo
echo -----------------------------------------------------------------
echo
echo Install
echo
echo -----------------------------------------------------------------
echo

make install
make install-docs

echo
echo -----------------------------------------------------------------
echo
echo Building contrib
echo
echo -----------------------------------------------------------------
echo

cd contrib
make all
make install

ldconfig
