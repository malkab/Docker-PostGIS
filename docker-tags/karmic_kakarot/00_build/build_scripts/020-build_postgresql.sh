#!/bin/bash

echo
echo ---------------------------------------
echo Configuring PostgreSQL
echo ---------------------------------------
echo

cd /usr/local/src/postgresql-$PG_VERSION

./configure \
	--prefix=/usr/local \
	--with-pgport=5432 \
	--with-python \
	--with-openssl \
	--with-libxml \
	--with-libxslt \
	--with-zlib

make
make install
make install-docs

cd contrib
make all
make install

ldconfig
