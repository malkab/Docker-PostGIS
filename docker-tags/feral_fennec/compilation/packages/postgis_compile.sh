# Compilation of PostgreSQL, GEOS, Proj, GDAL, and PostGIS 2

# Update and apt-get basic packages

echo
echo ---------------------------------------
echo Installing packages
echo ---------------------------------------
echo

apt-get update

apt-get install -y \
	build-essential \
	xsltproc \
	libcunit1 \
	libcunit1-doc \
	libcunit1-dev \
	zlib1g-dev \
	libreadline6-dev \
	apt-file \
	libssl-dev \
	vim \
	less \
	mlocate \
	libxml2-dev \
	libxslt-dev \
	curl \
	unzip \
	locales \
	locate \
	libjson-c-dev \
	python3 \
	libpython3.6 \
	libpython3-dev \
	libpython3-all-dev \
	libsqlite3-0 \
	libsqlite3-dev \
	sqlite3

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

cd ../..

ldconfig


# Compilation of Proj

cd proj

tar -xvf proj-$PROJ_VERSION.tar.gz

unzip -o proj-datumgrid-1.8.zip -d proj-6.2.0/data/

unzip -o proj-datumgrid-europe-1.4.zip -d proj-6.2.0/data/

unzip -o proj-datumgrid-north-america-1.2.zip -d proj-6.2.0/data/

unzip -o proj-datumgrid-oceania-1.0.zip -d proj-6.2.0/data/

unzip -o proj-datumgrid-world-1.0.zip -d proj-6.2.0/data/

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

ldconfig


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

./configure --with-topology --with-raster --with-jsondir=/usr/include/json-c

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
