# Compilation of PostgreSQL, GEOS, Proj4, GDAL, and PostGIS 2

# Update and apt-get basic packages
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
	libxslt1-dev \
	curl \
	locales \
	libjson-c-dev \
	python2.7 \
	libpython2.7 \
	libpython2.7-dev \
	libpython-all-dev \
	imagemagick \
	dblatex 

ldconfig

# Update apt-file 
apt-file update

# Compilation of PostgreSQL
cd src/postgresql/postgresql-${PG_VERSION} 

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

cd contrib

make all

make install 

ldconfig

cd ../../../..

# Compilation of GEOS
cd src/geos/geos-${GEOS_VERSION}

./configure

make

make install

cd ../../..

ldconfig


# Compilation of Proj 4
/bin/cp -fr src/proj-datumgrid/proj-datumgrid/* src/proj/proj-${PROJ4_VERSION}/nad

/bin/cp -fr src/proj-patch/pj_datums.c src/proj/proj-${PROJ4_VERSION}/src

/bin/cp -fr src/proj-patch/epsg src/proj/proj-${PROJ4_VERSION}/nad/

/bin/cp -fr src/proj-patch/PENR2009.gsb src/proj/proj-${PROJ4_VERSION}/nad/

cd src/proj/proj-${PROJ4_VERSION}

./configure

make

make install

cd ../../..

ldconfig


# Compilation of GDAL
cd src/gdal/gdal-${GDAL_VERSION}

./configure

make

make install

cd ../../..

/bin/cp -fr src/gdal-patch/data/epsg.wkt /usr/local/share/gdal

/bin/cp -fr src/gdal-patch/data/gcs.csv /usr/local/share/gdal

chmod 644 /usr/local/share/gdal/*

ldconfig


# Compilation of PostGIS
/bin/cp -fr src/postgis-patch/spatial_ref_sys.sql src/postgis/postgis-${POSTGIS_VERSION}/

cd src/postgis/postgis-${POSTGIS_VERSION}

./configure --with-topology --with-raster --with-jsondir=/usr/include/json-c

make

make install

cd ../../..

ldconfig

