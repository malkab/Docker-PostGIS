# Compilation of PostgreSQL, GEOS, Proj, GDAL, and PostGIS 2

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
	libssl-dev \
	vim \
	vim-common \
	vim-tiny \
	less \
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

# Compilation of PostgreSQL
echo
echo ---------------------------------------
echo Configuring PostgreSQL
echo ---------------------------------------
echo

cd postgresql

tar -xvf postgresql-$PG_VERSION.tar.bz2

cd postgresql-$PG_VERSION

LDFLAGS=-lstdc++ ./configure \
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

echo
echo ---------------------------------------
echo Building PostgreSQL contrib
echo ---------------------------------------
echo

cd contrib

make all

make install

ldconfig

cd ../../..


# Compilation of GEOS

echo
echo ---------------------------------------
echo Configuring GEOS
echo ---------------------------------------
echo

cd geos

tar -xvf geos-$GEOS_VERSION.tar.bz2

cd geos-$GEOS_VERSION

./configure

echo
echo ---------------------------------------
echo Building GEOS
echo ---------------------------------------
echo

make

echo
echo ---------------------------------------
echo Installing GEOS
echo ---------------------------------------
echo

make install

ldconfig

cd ../..


# Compilation of Proj

cd proj

tar -xvf proj-$PROJ_VERSION.tar.gz

echo
echo ---------------------------------------
echo Configuring PROJ
echo ---------------------------------------
echo

cd proj-$PROJ_VERSION

./configure

echo
echo ---------------------------------------
echo Building PROJ
echo ---------------------------------------
echo

make

echo
echo ---------------------------------------
echo Installing PROJ
echo ---------------------------------------
echo

make install

cd ../..

echo
echo ---------------------------------------
echo Installing proj-data
echo ---------------------------------------
echo

cd proj-data

tar -xvf proj-data-$PROJ_DATA_VERSION.tar.gz -C $PROJ_LIB

# A PROJ hack
ln -s /usr/local/share/proj/es_ign_SPED2ETV2.tif /usr/local/share/proj/PENR2009.gsb
ln -s /usr/local/share/proj/es_ign_SPED2ETV2.tif /usr/local/share/proj/BALR2009.gsb

ldconfig

cd ..


# Compilation of GDAL

echo
echo ---------------------------------------
echo Configuring GDAL
echo ---------------------------------------
echo

cd gdal

tar -xvf gdal-$GDAL_VERSION.tar.gz

cd gdal-$GDAL_VERSION

./configure

echo
echo ---------------------------------------
echo Building GDAL
echo ---------------------------------------
echo

make

echo
echo ---------------------------------------
echo Installing GDAL
echo ---------------------------------------
echo

make install

ldconfig

cd ../..


# Compilation of PostGIS
echo
echo ---------------------------------------
echo Configuring PostGIS
echo ---------------------------------------
echo

cd postgis

tar -xvf postgis-$POSTGIS_VERSION.tar.gz

cd postgis-$POSTGIS_VERSION

./configure --with-topology --with-raster

echo
echo ---------------------------------------
echo Building PostGIS
echo ---------------------------------------
echo

make

echo
echo ---------------------------------------
echo Installing PostGIS
echo ---------------------------------------
echo

make install

ldconfig

cd ../..
