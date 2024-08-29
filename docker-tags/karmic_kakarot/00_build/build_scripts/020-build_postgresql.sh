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

echo
echo ---------------------------------------
echo Building PostgreSQL
echo ---------------------------------------
echo

make

echo
echo ---------------------------------------
echo Installing PostgreSQL
echo ---------------------------------------
echo

make install
make install-docs

echo
echo ---------------------------------------
echo Building PostgreSQL contrib
echo ---------------------------------------
echo

cd contrib

make all

make install

ldconfig
