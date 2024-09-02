#!/bin/bash

# Update and apt-get basic packages

# For autoinstalling tzdata
ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime

DEBIAN_FRONTEND=noninteractive

apt-get install -y \
	build-essential \
	xsltproc \
	libcunit1 \
	libcunit1-doc \
	libcunit1-dev \
	zlib1g-dev \
	libreadline-dev \
	bison \
	flex \
	libssl-dev \
	vim \
	vim-common \
	vim-tiny \
	less \
  	cmake \
	libxml2-dev \
	libxslt1-dev \
	curl \
	zip \
	unzip \
	locales \
	libjson-c-dev \
	python3 \
	python3-distutils \
	python3-pip \
	libpython3-dev \
	libpython3-all-dev \
	libsqlite3-0 \
	libsqlite3-dev \
	pkg-config \
	libcurl4-openssl-dev \
	libtiff6 \
	libtiff-dev \
	sqlite3 \
	protobuf-c-compiler \
	protobuf-compiler \
	libprotobuf-c-dev \
	libprotobuf-c1 \
	libpcre3-dev \
	libpcre3 \
	libopenjp2-7-dev \
	swig \
	libgeotiff5 \
	libgeotiff-dev \
	libpng-dev \
	libpng16-16 \
	python3-numpy \
	libxml2 \
	libxml2-utils

dpkg-reconfigure --frontend noninteractive tzdata

ldconfig
