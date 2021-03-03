# Compilation of PostgreSQL, GEOS, Proj4, GDAL, and PostGIS 2


# Update and apt-get basic packages
apt-get update && \
apt-get install -y \
	build-essential \
	xsltproc \
	imagemagick \
	dblatex \
	libcunit1 \
	libcunit1-doc \
	libcunit1-dev \
	zlib1g-dev \
	python \
	python-dev \
	libreadline6-dev \
	libssl-dev \
	libxml2-dev \
	libxslt-dev \
	curl \
	locales \
	libjson-c-dev


# Untar
cd src ; tar -xjvf postgresql-${PG_VERSION}.tar.bz2 ; cd ..
cd src ; tar -xjvf geos-${GEOS_VERSION}.tar.bz2 ; cd ..
cd src ; tar -xvf proj-${PROJ4_VERSION}.tar.gz ; cd ..
cd src ; mkdir -p proj-datumgrid ; cd ..
cd src ; tar -xvf proj-datumgrid-1.5.tar.gz -C proj-datumgrid ; cd ..
cd src ; tar -xvf gdal-${GDAL_VERSION}.tar.gz ; cd ..
cd src ; tar -xvf postgis-${POSTGIS_VERSION}.tar.gz ; cd ..


# Compilation of PostgreSQL
cd src/postgresql-${PG_VERSION} ; \
./configure --prefix=/usr/local --with-pgport=5432 --with-python --with-openssl --with-libxml --with-libxslt --with-zlib ; \
cd ../..

cd src/postgresql-${PG_VERSION} ; make ; cd ../..

cd src/postgresql-${PG_VERSION} ; make install ; cd ../..

cd src/postgresql-${PG_VERSION}/contrib ; make all ; cd ../../..

cd src/postgresql-${PG_VERSION}/contrib ; make install ; cd ../../..

ldconfig


# Compilation of GEOS
cd src/geos-${GEOS_VERSION} ; ./configure ; cd ../..

cd src/geos-${GEOS_VERSION} ; make ; cd ../..

cd src/geos-${GEOS_VERSION} ; make install ; cd ../..

ldconfig


# Compilation of Proj 4
mv src/proj-datumgrid/* src/proj-${PROJ4_VERSION}/nad

mv src/pj_datums.c src/proj-${PROJ4_VERSION}/src

mv src/epsg src/proj-${PROJ4_VERSION}/nad/

mv src/PENR2009.gsb src/proj-${PROJ4_VERSION}/nad/

cd src/proj-${PROJ4_VERSION} ; ./configure ; cd ../..

cd src/proj-${PROJ4_VERSION} ; make ; cd ../..

cd src/proj-${PROJ4_VERSION} ; make install ; cd ../..

ldconfig


# Compilation of GDAL
cd src/gdal-${GDAL_VERSION} ; ./configure ; cd ../..

cd src/gdal-${GDAL_VERSION} ; make ; cd ../..

cd src/gdal-${GDAL_VERSION} ; make install ; cd ../..

mv src/epsg.wkt /usr/local/share/gdal

mv src/gcs.csv /usr/local/share/gdal

chmod 644 /usr/local/share/gdal/*

ldconfig


# Compilation of PostGIS
mv src/spatial_ref_sys.sql src/postgis-${POSTGIS_VERSION}/

cd src/postgis-${POSTGIS_VERSION} ; ./configure --with-topology --with-raster --with-jsondir=/usr/include/json-c ; cd ../..

cd src/postgis-${POSTGIS_VERSION} ; make ; cd ../..

cd src/postgis-${POSTGIS_VERSION} ; make install ; cd ../..

ldconfig


# Clean up
rm -Rf src
rm -rf /var/lib/apt/lists/*
