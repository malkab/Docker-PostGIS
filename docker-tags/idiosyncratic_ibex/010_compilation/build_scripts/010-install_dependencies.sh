#!/bin/bash

# Update and apt-get basic packages

echo
echo ---------------------------------------
echo Installing packages
echo ---------------------------------------
echo

# For autoinstalling tzdata
ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime

DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -y \
	build-essential \
	xsltproc \
	libcunit1 \
	libcunit1-doc \
	libcunit1-dev \
	zlib1g-dev \
	libreadline-dev \
	apt-file \
	bison \
	flex \
	libssl-dev \
	vim \
	vim-common \
	vim-tiny \
	less \
  cmake \
	mlocate \
	libxml2-dev \
	libxslt1-dev \
	curl \
	zip \
	unzip \
	locales \
	locate \
	libjson-c-dev \
	python3 \
	python3-distutils \
	libpython3-dev \
	libpython3-all-dev \
	libsqlite3-0 \
	libsqlite3-dev \
	pkg-config \
	libcurl4-openssl-dev \
	libtiff5 \
	libtiff5-dev \
	sqlite3 \
	protobuf-c-compiler \
	protobuf-compiler \
	libprotobuf-c-dev \
	libprotobuf-c1 \
	libpcre++-dev \
	libpcre++0v5

dpkg-reconfigure --frontend noninteractive tzdata

ldconfig

# Make Python3 default
ln -s /usr/bin/python3 /usr/bin/python

# Update apt-file
apt-file update

# Update locate DB
updatedb
